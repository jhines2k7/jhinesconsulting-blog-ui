import './views/home'
import './views/about'
import './views/contact'
import './views/blog'
import './views/blog.article'
import './views/project.detail'
import './components/home/about.area'
import './components/home/service.area'
import './components/home/welcome.area'
import './components/home/work.area'
import './components/home/testimonial.area'
import './components/home/skill.ratings'
import './components/top.nav'
import './components/site.header'
import './components/site.footer'
import './components/contact.area'
import './components/top.nav'
import './components/inner.page'
import './components/contact.form'
import './components/blog.widget'
import './components/comment.widget'

import Storage from './storage'
import {Router} from 'director/build/director'
import riot from 'riot'
import EventStore from './eventStore'

let eventStore = null;

let home = (hash) => {
    'use strict';

    fetch('data/projects.json')
        .then(function(response) {
            return response.json();
        })
        .then(function(projects) {
            if(document.getElementsByTagName('home').length === 0) {
                let home = document.createElement('home');

                let footer = document.getElementsByTagName('site-footer')[0];

                let body = document.getElementsByTagName('body')[0];

                body.insertBefore(home, footer);

                riot.mount('home');
            }

            let events = [];

            let tagName;

            if(typeof hash !== 'undefined') {
                if(hash === 'services') {
                    tagName = 'service-area';
                } else if(hash === 'work') {
                    tagName = 'work-area';
                }

                events.push({
                    channel: 'scroll',
                    topic: 'app.update.scrollTo',
                    data: tagName
                })
            }

            events.push({
                channel: 'routing',
                topic: 'app.update.currentView',
                data: 'home'
            },{
                channel: 'projects',
                topic: 'app.update.projects',
                data: projects
            });

            eventStore.add(eventStore.events, events);
        });

    highlightActiveMenuItem('home');
};

let highlightActiveMenuItem = (item) => {
    let activeMenuItem = Array.from(document.getElementsByClassName('main_menu')[0].children).filter((li) => {
        return li.innerText === item;
    });

    if(activeMenuItem.length > 0) {
        activeMenuItem[0].className = 'active';
    }
};

let about = () => {
    'use strict';

    let about = document.createElement('about');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(about, footer);

    riot.mount('about');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'app.update.currentView',
        data: 'about'
    }, {
        channel: 'routing',
        topic: 'app.update.innerPage',
        data: 'About Me'
    }]);

    highlightActiveMenuItem('about');
};

let contact = () => {
    'use strict';

    let contact = document.createElement('div');
    contact.setAttribute('data-is', 'contact');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(contact, footer);

    riot.mount('contact');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'app.update.currentView',
        data: 'contact'
    }, {
        channel: 'routing',
        topic: 'app.update.innerPage',
        data: 'Contact Me'
    }]);

    highlightActiveMenuItem('contact');
};

let projectDetail = (slug) => {
    'use strict';

    fetch('data/projects.json')
        .then(function(response) {
            return response.json();
        })
        .then(function(projects) {
            let projectDetail = document.createElement('project-detail');

            let footer = document.getElementsByTagName('site-footer')[0];

            let body = document.getElementsByTagName('body')[0];

            body.insertBefore(projectDetail, footer);

            riot.mount('project-detail');

            let project = projects.find((project) => project.slug === slug);

            eventStore.add(eventStore.events, [{
                channel: 'routing',
                topic: 'app.update.currentView',
                data: 'projectDetail'
            }, {
                channel: 'routing',
                topic: 'app.update.project',
                data: project
            }]);
        });

    highlightActiveMenuItem('work');
};

let blog = () => {
    'use strict';

    fetch('data/articles.json')
        .then(function(response) {
            return response.json();
        })
        .then(function(articles) {
            let blog = document.createElement('blog');

            let footer = document.getElementsByTagName('site-footer')[0];

            let body = document.getElementsByTagName('body')[0];

            body.insertBefore(blog, footer);

            riot.mount('blog');

            eventStore.add(eventStore.events, [{
                channel: 'routing',
                topic: 'app.update.currentView',
                data: 'blog'
            }, {
                channel: 'routing',
                topic: 'app.update.innerPage',
                data: 'Blog'
            }, {
                channel: 'blog',
                topic: 'app.update.articles',
                data: articles
            }]);
        });

    highlightActiveMenuItem('blog');
};

let blogArticle = (slug) => {
    'use strict';

    fetch('data/articles.json')
        .then(function(response) {
            return response.json();
        })
        .then(function(articles) {
            let blogArticle = document.createElement('blog-article');

            let footer = document.getElementsByTagName('site-footer')[0];

            let body = document.getElementsByTagName('body')[0];

            body.insertBefore(blogArticle, footer);

            riot.mount('blog-article');

            let article = articles.find( (article) => article.slug === slug );

            eventStore.add(eventStore.events, [{
                channel: 'routing',
                topic: 'app.update.currentView',
                data: 'blogArticle'
            }, {
                channel: 'blog',
                topic: 'app.update.article',
                data: article
            }, {
                channel: 'blog',
                topic: 'app.update.articles',
                data: articles
            }]);
        });

    highlightActiveMenuItem('blog');
};

let renderHeaderAndFooter = () => {
    riot.mount('site-header');
    riot.mount('site-footer');
};

Storage.get().then( (events) => {
    eventStore = new EventStore(events);

    let router = Router({
        '/': home,
        '/about': about,
        '/contact': contact,
        '/projects/:slug': projectDetail,
        '/blog': blog,
        '/blog/:slug': blogArticle,
        '/:hash': home
    });

    router.configure({
        before: renderHeaderAndFooter
    });

    router.init(['/']);
});

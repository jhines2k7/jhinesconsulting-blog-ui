import './views/home'
import './components/top.nav'
import './components/site.header'
import './components/home/about.area'
import './components/home/contact.area'
import './components/home/service.area'
import './components/site.footer'
import './components/home/testimonial.area'
import './components/top.nav'
import './components/home/welcome.area'
import './components/home/work.area'
import './views/blog'
import './views/about'
import './views/contact'
import './views/blog.article'
import './components/inner.page'
import './components/contact/contact.form'
import './components/contact/contact.map'

import Storage from './storage'
import {Router} from 'director/build/director'
import riot from 'riot'
import EventStore from './eventStore'

let eventStore = null;

let home = () => {
    'use strict';

    let home = document.createElement('home');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(home, footer);

    riot.mount('home');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'app.update.currentView',
        data: 'home'
    }]);
};

let blog = () => {
    'use strict';

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
    }]);
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
};

let contact = () => {
    'use strict';

    let contact = document.createElement('contact');

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
};

let blogArticle = (id) => {
    'use strict';

    let article = document.createElement('blog-article');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(article, footer);

    riot.mount('blog-article');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'app.update.currentView',
        data: 'article'
    }, {
        channel: 'routing',
        topic: 'app.update.innerPage',
        data: 'Blog Article Title Here'
    }]);
};

let renderHeaderAndFooter = () => {
    riot.mount('site-header');
    riot.mount('site-footer');
};

Storage.get().then( (events) => {
    eventStore = new EventStore(events);

    let router = Router({
        '/': home,
        '/blog': blog,
        '/about': about,
        '/contact': contact,
        '/blog/:id': blogArticle,
    });

    router.configure({
        before: renderHeaderAndFooter
    });

    router.init();
});

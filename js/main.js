import './views/home'
import './components/top.nav'
import './components/site.header'
import './components/home/about.area'
import './components/home/contact.area'
import './components/home/service.area'
import './components/site.footer'
import './components/home/testimonial.area'
import './components/home/skill.ratings'
import './components/top.nav'
import './components/home/welcome.area'
import './components/home/work.area'
import './views/about'
import './views/contact'
import './views/project.detail'
import './components/inner.page'
import './components/contact/contact.form'

import Storage from './storage'
import {Router} from 'director/build/director'
import riot from 'riot'
import EventStore from './eventStore'

let eventStore = null;

let home = (hash) => {
    'use strict';

    let home = document.createElement('home');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(home, footer);

    riot.mount('home');

    let events = [];

    let tagName;

    if(typeof hash !== 'undefined') {
        if(hash === 'service') {
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
    });

    eventStore.add(eventStore.events, events);

    highlightActiveMenuItem('home');
};

let highlightActiveMenuItem = (item) => {
    let activeMenuItem = Array.from(document.getElementsByClassName('main_menu')[0].children).filter((li) => {
        return li.innerText === item;
    });

    activeMenuItem[0].className = 'active';
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

let projectDetail = (id) => {
    'use strict';

    let projectDetail = document.createElement('project-detail');

    let footer = document.getElementsByTagName('site-footer')[0];

    let body = document.getElementsByTagName('body')[0];

    body.insertBefore(projectDetail, footer);

    riot.mount('project-detail');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'app.update.currentView',
        data: 'projectDetail'
    }, {
        channel: 'routing',
        topic: 'app.update.innerPage',
        data: 'Project Title Here'
    }]);

    highlightActiveMenuItem('work');
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
        '/projects/:id': projectDetail,
        '/:hash': home
    });

    router.configure({
        before: renderHeaderAndFooter
    });

    router.init(['/']);
});

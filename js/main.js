import './views/home.view'
import './components/top.nav'
import './components/site.header'
import './components/about.area'
import './components/contact.area'
import './components/service.area'
import './components/site.footer'
import './components/testimonial.area'
import './components/top.nav'
import './components/welcome.area'
import './components/work.area'
import './views/blog.view'

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
        '/blog': blog
    });

    router.configure({
        before: renderHeaderAndFooter
    });

    router.init();
});

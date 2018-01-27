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

import Storage from './storage'
import {Router} from 'director/build/director'
import riot from 'riot'
import EventStore from './eventStore'

let eventStore = null;

let home = () => {
    'use strict';

    riot.mount('site-header');

    document.body.appendChild(document.createElement('home'));
    riot.mount('home');

    eventStore.add(eventStore.events, [{
        channel: 'routing',
        topic: 'blog.update.currentView',
        data: 'home'
    }]);
};

Storage.get().then( (events) => {
    eventStore = new EventStore(events);

    let router = Router({
        '/': home
    });

    router.init();
});

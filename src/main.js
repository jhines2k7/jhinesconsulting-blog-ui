import './views/home.view'
import './components/top.nav'
import './components/site.header'

import Storage from './storage'
import {Router} from 'director/build/director'
import riot from 'riot'
import EventStore from './eventStore'

let eventStore = null;

let home = () => {
    'use strict';

    if(document.getElementsByTagName('top-nav').length === 0) {
        document.body.appendChild(document.createElement('top-nav'));
        riot.mount('top-nav');
    }

    document.body.appendChild(document.createElement('home'));
    riot.mount('home');
};

Storage.get().then( (events) => {
    eventStore = new EventStore(events);

    let router = Router({
        '/': home
    });

    router.init();
});

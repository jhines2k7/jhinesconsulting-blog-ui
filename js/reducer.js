export default function reduce(events) {
    "use strict";

    return events.reduce( (state, event) => {
        if(event.topic === 'app.update.currentView') {
            state.currentView = event.data;
        }

        if(event.topic === 'app.update.innerPage') {
            state.pageTitle = event.data;
        }

        if(event.topic === 'app.update.scrollTo') {
            state.scrollTo = event.data;
        }

        return state;
    }, {
        currentView: 'home',
        heroText: '',
        contactForm: {
            name: '',
            email: '',
            message: ''
        },
        pageTitle: '',
        scrollTo: ''
    })
}
export default function reduce(events) {
    "use strict";

    return events.reduce( (state, event) => {
        return state;
    }, {
        currentView: 'home',
        heroText: '',
        contactForm: {
            name: '',
            email: '',
            message: ''
        }
    })
}
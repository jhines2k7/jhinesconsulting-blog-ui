export default function reduce(events) {
    "use strict";

    return events.reduce( (state, event) => {
        if(event.topic === 'admin.signout.success') {
            state.user.isLoggedIn = false;
        }

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
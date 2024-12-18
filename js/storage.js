import localforage from 'localforage/dist/localforage'

export default class Storage {
    static set(events) {
        console.log('Added to storage', events);

        localforage.setItem('jhines-consulting-blog', events).catch(function(err) {
            // This code runs if there were any errors
            console.error(err);
        });
    }

    static get() {
        return localforage.getItem('jhines-consulting-blog').then( (events) => {
            // This code runs once the value has been loaded
            // from the offline store.
            if(events === null) {
                events = [];
            }

            console.log('Returned from storage', events);

            return events;
        }).catch(function(err) {
            // This code runs if there were any errors
            console.error(err);
        });
    }
}
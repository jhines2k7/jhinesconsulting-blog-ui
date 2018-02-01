<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li><a href="#/">home</a></li>
            <li><a href="#/about">about</a></li>
            <li><a onclick={ scrollTo } href="#service">services</a></li>
            <li><a onclick={ scrollTo } href="#work">work</a></li>
            <li><a href="#/contact">contact</a></li>
        </ul>
    </nav>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'
        import {Router} from 'director/build/director'


        this.viewModel = {};

        this.currentView = '';

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        scrollTo(e) {
            let hash = e.srcElement.innerHTML;
            let tagName;

            if(hash === 'services') {
                tagName = 'service-area';
            } else {
                tagName = 'work-area';
            }

            if(this.currentView !== 'home'){
                eventStore.add(eventStore.events, [{
                    channel: 'scroll',
                    topic: 'app.update.scrollTo',
                    data: tagName
                }]);

                Router().setRoute('/');
            } else {
                document.getElementsByTagName(tagName)[0].scrollIntoView(true);
            }
        }

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    this.currentView = state.currentView;
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</top-nav>
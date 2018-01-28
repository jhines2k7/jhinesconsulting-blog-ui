<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li><a href="#/">home</a></li>
            <li><a href="#/about">about</a></li>
            <li><a href="#service">services</a></li>
            <li><a href="#work">work</a></li>
            <li><a href="#/blog">blog</a></li>
            <li><a href="#/contact">contact</a></li>
        </ul>
    </nav>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

        this.currentView = '';

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

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
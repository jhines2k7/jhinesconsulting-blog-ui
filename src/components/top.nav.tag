<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li class="submenu_parents"><a href="index.html">home</a>
                <ul class="submenu">
                    <li><a href="index.html">home1</a></li>
                    <li><a href="index2.html">home2</a></li>
                    <li><a href="index3.html">home3</a></li>
                    <li><a href="index4.html">home4</a></li>
                    <li><a href="index5.html">home5</a></li>
                </ul>
            </li>
            <li><a href="about.html">about</a></li>
            <li><a href="#service">services</a></li>
            <li><a href="#work">work</a></li>
            <li class="submenu_parents"><a href="blog.html">blog</a>
                <ul class="submenu">
                    <li><a href="blog.html">Blog</a></li>
                    <li><a href="single_blog.html">Blog Details</a></li>
                </ul>
            </li>
            <li><a href="contact.html">contact</a></li>
        </ul>
    </nav>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        subscribe(channel, topic) {
            let subscription = postal.subscribe({
                channel: channel,
                topic: topic,
                callback: function(data, envelope) {                    
                    let state = reduce(eventStore.events);

                    if(state.currentView === 'login') {
                        this.unmount();
                    }

                }.bind(this)
            });

            return subscription;
        };

        this.subscribe('routing', 'admin.update.currentView');
    </script>
</top-nav>
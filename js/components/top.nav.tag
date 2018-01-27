<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li><a href="#/">home</a></li>
            <li><a href="about.html">about</a></li>
            <li><a href="#service">services</a></li>
            <li><a href="#work">work</a></li>
            <li><a href="#/blog">blog</a></li>
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
    </script>
</top-nav>
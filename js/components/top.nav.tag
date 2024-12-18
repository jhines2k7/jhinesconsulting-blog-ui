<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li>
                <a if={ !showMobileNav } onclick={ toggleNav } class="icon">&#9776;</a>
                <a if={ showMobileNav } onclick={ toggleNav } class="icon saltire">&#9747;</a>
            </li>
            <li><a href="#/">home</a></li>
            <li><a href="#/about">about</a></li>
            <li><a onclick={ scrollTo } href="#services">services</a></li>
            <li><a onclick={ scrollTo } href="#work">work</a></li>
            <li><a href="#/blog">blog</a></li>
            <li><a href="#/contact">contact</a></li>
        </ul>
    </nav>

    <nav if={ showMobileNav } class="mobile-nav">
        <ul class="mobile-menu">
            <li><a href="#/about">about</a></li>
            <li><a onclick={ scrollTo } href="#services">services</a></li>
            <li><a onclick={ scrollTo } href="#work">work</a></li>
            <li><a href="#/blog">blog</a></li>
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

        this.showMobileNav = true;

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        toggleNav(e) {
            this.showMobileNav = !this.showMobileNav;

            if(this.showMobileNav) {
                document.getElementsByTagName('body')[0].style.overflow = 'hidden';

                // Disable scrolling on ios
                document.ontouchmove =  (e) => {
                  e.preventDefault();
                }
            } else {
                document.getElementsByTagName('body')[0].style.overflow = '';

                // Enable scrolling on ios
                document.ontouchmove = (e) => {
                    return true;
                }
            }
        }

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

                    if(envelope.topic === 'app.update.hideMobileNav') {
                        this.showMobileNav = false;

                        document.getElementsByTagName('body')[0].style.overflow = '';

                        this.update();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('routing', 'app.update.hideMobileNav');
    </script>
</top-nav>
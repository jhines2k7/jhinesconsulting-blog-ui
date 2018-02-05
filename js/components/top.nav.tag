<top-nav>
    <nav class="menu_bar">
        <ul class="main_menu">
            <li><a onclick={ toggleNav } class="icon">&#9776;</a></li>
            <li><a href="#/">home</a></li>
            <li><a href="#/about">about</a></li>
            <li><a onclick={ scrollTo } href="#services">services</a></li>
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

        toggleNav(e) {
            document.getElementsByTagName('top-nav')[0].classList.add('responsive');

            Array.from(document.getElementsByClassName("main_menu")[0].children).forEach(function(item) {
                if(item.textContent !== 'home') {
                    if(item.children[0].className !== 'icon') {
                        let anchorTag = item.childNodes[0];

                        if(anchorTag.style.display === '' || anchorTag.style.display === 'none'){
                            anchorTag.style.display = 'inline-block';
                        } else if(anchorTag.style.display === 'inline-block'){
                            anchorTag.style.display = 'none';

                        }
                    }
                }
            });
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
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</top-nav>
<contact>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite"></div>
    <!--02.InnerPage Area End-->
    <!--03.ContactPage Area Start-->
    <div data-is="contact-area" class="contact_area section_padding"></div>
    <!--03.ContactPage Area End-->
    <!--08.ContactMap Start -->
    <div class="map" id="googleMap"></div>
    <!--08.ContactMap end -->

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'
        import initialize from '../initializeMap'

        this.viewModel = {};

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
            document.body.scrollTop = document.documentElement.scrollTop = 0;

            initialize();
        });

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    if(state.currentView !== 'contact') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</contact>
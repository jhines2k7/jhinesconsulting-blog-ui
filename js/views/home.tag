<home>
    <!--Welcome Area Start -->
    <welcome-area></welcome-area>
    <!--Welcome Area End -->

    <!--Service Area Start -->
    <service-area></service-area>
    <!--Service Area End -->

    <!--Work Area Start -->
    <work-area></work-area>
    <!--Work Area End -->

    <!--Contact Area Start -->
    <div data-is="contact-area" class="contact_area"></div>
    <!--Contact Area End -->

    <!--About Area Start -->
    <about-area></about-area>
    <!--About Area End -->

    <!--Testimonial Area Start -->
    <!--<testimonial-area></testimonial-area>-->
    <!--Testimonial Area End -->

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

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

                    if(state.currentView !== 'home') {
                        this.unmount();
                    } else {
                        if(state.scrollTo !== ''){
                            document.getElementsByTagName(state.scrollTo)[0].scrollIntoView(true);

                            eventStore.add(eventStore.events, [{
                                channel: 'scroll',
                                topic: 'app.update.scrollTo',
                                data: ''
                            }]);
                        }
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('scroll', 'app.update.scrollTo');
    </script>
</home> 

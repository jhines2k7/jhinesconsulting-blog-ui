<home>
    <!--02.Welcome Area Start -->
    <welcome-area></welcome-area>
    <!--02.Welcome Area End -->

    <!--03.About Area Start -->
    <about-area></about-area>
    <!--03.About Area End -->

    <!--04.Service Area Start -->
    <service-area></service-area>
    <!--04.Service Area End -->

    <!--05.Work Area Start -->
    <work-area></work-area>
    <!--05.Work Area End -->

    <!--06.Testimonial Area Start -->
    <testimonial-area></testimonial-area>
    <!--06.Testimonial Area End -->

    <!--07.Contact Area Start -->
    <contact-area></contact-area>
    <!--07.Contact Area End -->

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
            document.body.scrollTop = document.documentElement.scrollTop = 0;
        });

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    if(state.currentView !== 'home') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</home> 

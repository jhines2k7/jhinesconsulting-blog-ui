<contact>
    <!--02.InnerPage Area Start-->
    <inner-page></inner-page>
    <!--02.InnerPage Area End-->
    <!--03.ContactPage Area Start-->
    <div class="contact_area section_padding">
        <div class="container">
            <div class="contact_colum4">
                <div class="contact_inf_wraper">
                    <div class="single_contact_inf">
                        <div class="contact_icon"><i class="fa fa-envelope" aria-hidden="true"></i></div>
                        <div class="contact_inf_contact">
                            <h4>Email:</h4>
                            <div class="contact_inf">
                                <a href="mailto:support24@gmail.com">support24@gmail.com</a>
                                <a href="mailto:emailhere@gmail.com">emailhere@gmail.com</a>
                            </div>
                        </div>
                    </div>
                    <div class="single_contact_inf">
                        <div class="contact_icon"><i class="fa fa-phone" aria-hidden="true"></i></div>
                        <div class="contact_inf_contact">
                            <h4>Phone::</h4>
                            <div class="contact_inf">
                                <a href="tel:+00968697457">+00 968 - 697 - 457</a>
                                <a href="tel:+00568568869">+00 568 - 568 - 869</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="contact_colum8">
                <contact-form></contact-form>
            </div>
        </div>
    </div>
    <!--03.ContactPage Area End-->
    <!--08.ContactMap Start -->
    <contact-map></contact-map>
    <!--08.ContactMap end -->

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

                    if(state.currentView !== 'contact') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</contact>
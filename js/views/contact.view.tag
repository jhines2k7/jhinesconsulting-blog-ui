<contact>
    <!--02.InnerPage Area Start-->
    <div class="inner_page_area background_ofwhite">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h1>Blog Post</h1>
                    <div class="inner_link">
                        <span>Home  -  </span><a href="#">blog</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                <div class="contact_form">
                    <div class="section_tittle">
                        <h1>Get in touch</h1>
                    </div>
                    <form action="https://formspree.io/crazycafe@gmail.com" method="POST">
                        <div class="input">
                            <input type="text" name="name" placeholder="Name here">
                        </div>
                        <div class="input">
                            <input type="email" name="email" placeholder="Email here" required>
                        </div>
                        <div class="textarea">
                            <textarea name="message" placeholder="Message here"></textarea>
                        </div>
                        <div class="form_btn">
                            <button type="submit" class="custom_btn">Submit Now <i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--03.ContactPage Area End-->
    <!--08.ContactMap Start -->
    <div class="map" id="googleMap"></div>
    <!--08.ContactMap end -->

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

                    if(state.currentView !== 'contact') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</contact>
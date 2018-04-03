<about>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite" style="background-image: url(assets/img/sunrise-about-bg.jpg);"></div>
    <!--02.InnerPage Area End-->
    <!--03.About Area Start -->
    <div class="about_area section_padding home2_about_area about_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-5">
                    <div class="home2_about_img effect7">
                        <img src="assets/img/me_at_cjug-cropped.jpg" alt="">
                        <div class="section_tittle">
                            <h1>A little about me</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 col-md-offset-1 col-sm-offset-1 col-sm-6">
                    <div class="about_wraper home2_about_wraper">
                        <div class="about_content">
                            <skill-ratings></skill-ratings>
                            <p>
                                I've worked as a contract software developer in the Columbus area for the last 7 years.
                                Sometimes it can be a challenge trying to be enthusiastic about a poorly managed project
                                that has very little impact on the organization for which I'm under contract.
                                That's just life for an individual contributor in very large organizations
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--03.About Area End -->
    <!--04.Resume Area Start -->
    <resume></resume>
    <!--04.Resume Area End -->
    <!--05.ContactPage Area Start-->
    <div data-is="contact-area" class="contact_area section_padding"></div>
    <!--05.ContactPage Area End-->
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

                    if(state.currentView !== 'about') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</about>
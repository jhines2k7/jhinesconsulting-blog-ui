<about>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite" style="background-image: url(assets/img/color-2174043.png);"></div>
    <!--02.InnerPage Area End-->
    <!--03.About Area Start -->
    <div class="about_area home2_about_area about_page_area section_padding_bottom">
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
                                I'm a Data Solutions Architect out of Columbus, OH and I’m going to help you grow your business.
                            </p>
                            <p>
                                I’ve worked as a software developer in some of the largest companies in the world, and
                                noticed there were tools and techniques to aid in the decision making process available
                                to Fortune 500 companies that smaller companies don’t have access to. Sometimes this is
                                due to a lack of awareness of what's possible and sometimes it's just too costly in
                                terms of money, but more importantly time.
                            </p>
                            <p>
                                There are a number of prepackaged business solutions available to help analyze business
                                intelligence, but who has time to learn how to properly use them? I'd like to take a
                                different approach. One that starts with a question: What areas of your business would
                                you like to improve?
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
    <div data-is="contact-area" class="contact_area"></div>
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
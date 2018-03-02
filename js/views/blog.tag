<blog>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite" style="background-image: url(assets/img/sunrise-about-bg.jpg);"></div>
    <!--02.InnerPage Area End-->
    <!--03.BlogPage Area Start-->
    <div class="blog_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-lg-9 col-sm-7">
                    <div class="blog_wraper">
                        <div class="single_blog">
                            <img src="assets/img/blog1.jpg" alt="">
                            <h3>Man travels around the world in 80 awesome selfie</h3>
                            <span class="blog_meta">Rubel Hossen / 22 December, 2017</span>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make.</p>
                            <a href="single_blog.html" class="custom_btn">Read more</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-5">
                    <div class="blog_widget_wraper">
                        <div class="single_blog_widget recent_post">
                            <div class="blog_widget_tittle">
                                <h3>Recent Post</h3>
                            </div>
                            <div class="single-recent_post">
                                <a href="#">Richard Norton is winning over are critics again</a>
                                <span class="blog_meta">22 December, 2017</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--03.BlogPage Area End-->
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

                    if(state.currentView !== 'blog') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</blog>
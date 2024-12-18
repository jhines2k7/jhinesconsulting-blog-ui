<blog-article>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite" style={ bannerImage }></div>

    <!--02.InnerPage Area End-->

    <!--03.BlogPage Area Start-->
    <div class="blog_page_area single_blog_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-lg-9 col-sm-7">
                    <div class="blog_wraper">
                        <div class="single_blog">
                            <div data-is={ component }></div>
                        </div>

                        <!--<comment-widget></comment-widget>-->

                    </div>
                </div>

                <blog-widget></blog-widget>

            </div>
        </div>
    </div>
    <!--03.BlogPage Area End-->
    <!--04.ContactPage Area Start-->
    <div data-is="contact-area" class="contact_area"></div>
    <!--04.ContactPage Area End-->
    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.component = '';

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

                    if (state.currentView !== 'blogArticle') {
                        this.unmount();
                    } else {
                        this.component = state.article.slug;

                        let banner = `background-image: url(${state.article.bannerImage});`;

                        if(this.component === 'setting-up-a-kafka-cluster-using-docker-swarm-1') {
                            banner += 'background-blend-mode: overlay';
                        }

                        this.bannerImage = banner;

                        eventStore.add(eventStore.events, [{
                            channel: 'routing',
                            topic: 'app.update.innerPage',
                            data: state.article.title
                        }]);

                        this.update();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('blog', 'app.update.article');
    </script>
</blog-article>
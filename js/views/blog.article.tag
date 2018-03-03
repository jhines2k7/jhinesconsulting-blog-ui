<blog-article>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite"></div>
    <!--02.InnerPage Area End-->

    <!--03.BlogPage Area Start-->
    <div class="blog_page_area single_blog_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-lg-9 col-sm-7">
                    <div class="blog_wraper">
                        <div class="single_blog">
                            <!--<blog-template></blog-template>-->
                            <img src="assets/img/blog1.jpg" alt="">
                            <h3>Setting Up A Kafka Cluster Using Docker Swarm</h3>
                            <span class="blog_meta">James Hines / March 3, 2018</span>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make. Extremely we promotion remainder eagerness enjoyment an. Ham her demands removal brought minuter raising invited gay. Contented consisted continual curiosity contained child dried in in aware do. You had met they song how feel lain evil near.</p>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make.</p>
                            <div class="important_content">
                                <h3>
                                    Dissuade estatic and properly sawen entire sorrow delight endeavor
                                    onemy moen eto horrible margaret suitable followed general speed
                                    deed vanity excuse amarm are lover offer scale.
                                </h3>
                            </div>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make. Extremely we promotion remainder eagerness enjoyment Ham her demands removal brought minuter raising invited gay.</p>
                        </div>

                        <comment-widget></comment-widget>

                    </div>
                </div>

                <blog-widget></blog-widget>

            </div>
        </div>
    </div>
    <!--03.BlogPage Area End-->
    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.article = '';

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        let articleDictionary = {
            "setting-up-a-kafka-cluster-using-docker-swarm": {
                component: "kafka-cluster-swarm",
                title: "Setting Up A Kafka Cluster Using Docker Swarm"
            }
        };

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    if (state.currentView !== 'blogArticle') {
                        this.unmount();
                    } else {
                        this.article = articleDictionary[state.article].component;

                        eventStore.add(eventStore.events, [{
                            channel: 'routing',
                            topic: 'app.update.innerPage',
                            data: articleDictionary[state.article].title
                        }]);
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('blog', 'app.update.article');
    </script>
</blog-article>
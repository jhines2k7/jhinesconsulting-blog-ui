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
                            <img src={ viewModel.article.image } alt="">
                            <h3>{ viewModel.article.title }</h3>
                            <span class="blog_meta">{ viewModel.article.author } / { viewModel.article.date }</span>

                            <raw></raw>

                        </div>

                        <!--<comment-widget></comment-widget>-->

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

        this.viewModel = {
            article: {}
        };

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

                    if (state.currentView !== 'blogArticle') {
                        this.unmount();
                    } else {
                        this.viewModel.article = state.article;

                        riot.tag('raw', '<span></span>', function(opts) {
                            if(opts.r) {
                                this.root.innerHTML = opts.r;
                            }
                        });

                        riot.mount('raw', {
                            r: state.article.content
                        });

                        eventStore.add(eventStore.events, [{
                            channel: 'routing',
                            topic: 'app.update.innerPage',
                            data: state.article.title
                        }]);

                        this.update(this.viewModel);
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('blog', 'app.update.article');
    </script>
</blog-article>
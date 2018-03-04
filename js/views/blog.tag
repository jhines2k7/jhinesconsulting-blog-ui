<blog>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite"></div>
    <!--02.InnerPage Area End-->
    <!--03.BlogPage Area Start-->
    <div class="blog_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-lg-9 col-sm-7">
                    <div class="blog_wraper">
                        <div class="single_blog" each={ article in viewModel.articles }>
                            <img src="{ article.image }" alt="">
                            <h3>{ article.title }</h3>
                            <span class="blog_meta">{ article.author } / { article.date }</span>
                            <p>{ article.summary }</p>
                            <a href=#/blog/{ article.slug } class="custom_btn">Read more</a>
                        </div>
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
            articles: []
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

                    if(state.currentView !== 'blog') {
                        this.unmount();
                    } else {
                        this.viewModel.articles = state.articles;

                        this.update(this.viewModel);
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('blog', 'app.update.articles');
    </script>
</blog>
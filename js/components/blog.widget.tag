<blog-widget>
    <div class="col-lg-3 col-md-4 col-sm-5">
        <div class="blog_widget_wraper">
            <div class="single_blog_widget recent_post">
                <div class="blog_widget_tittle">
                    <h3>Recent Posts</h3>
                </div>
                <div class="single-recent_post" each={ article in viewModel.articles }>
                    <a href="#/blog/{ article.slug }">{ article.title }</a>
                    <span class="blog_meta">{ article.date }</span>
                </div>
            </div>
        </div>
    </div>

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

            let state = reduce(eventStore.events);

            this.viewModel.articles = state.articles;

            this.update(this.viewModel);
        });
    </script>
</blog-widget>
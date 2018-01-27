<inner-page>
    <div class="inner_page_area background_ofwhite">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h1>{ viewModel.pageTitle }</h1>
                    <div class="inner_link">
                        <span>Home  -  </span><a href="blog.html">blog</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {
            pageTitle: ''
        };

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

                    this.viewModel.pageTitle = state.pageTitle;

                    this.update(this.viewModel);
                }
            });
        };

        subscribe('routing', 'app.update.innerPage');
    </script>
</inner-page>
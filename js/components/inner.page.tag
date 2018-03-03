<inner-page>
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>{ viewModel.pageTitle }</h1>
                <div if={ viewModel.giveCreditWhereDue } class="credit">image courtesy of: <a href={ viewModel.credit.url }>{ viewModel.credit.label }</a></div>
            </div>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {
            pageTitle: '',
            giveCreditWhereDue: false,
            credit: {
                url: 'http://www.seanmedgar.com/columbus-skyline-hdr-sunrise-variant/',
                label: 'seanmedgar.com'
            }
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
                    if(eventStore === null) {
                        eventStore = new EventStore();
                    }

                    let state = reduce(eventStore.events);

                    this.viewModel.pageTitle = state.pageTitle;

                    if(state.pageTitle === 'Contact Me') {
                        this.viewModel.giveCreditWhereDue = true;
                    }

                    this.update(this.viewModel);
                }
            });
        };

        subscribe('routing', 'app.update.innerPage');
    </script>
</inner-page>
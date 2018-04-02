<work-area>
    <div id="work" class="work_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="section_tittle">
                        <h1>Some of my recent work</h1>
                    </div>
                </div>
            </div>
            <div class="work_wraper">
                <div class="row">
                    <div class="col-md-6 col-md-offset-3 text-center">
                        <ul class="isotope_menu">
                            <li data-name=".branding"><span>360-Degree Customer</span></li>
                        </ul>
                    </div>
                </div>

                <div class="only-one single_work_wraper branding" each={ project in viewModel.projects }>
                    <a href="#/projects/{project.slug}" class="single_work">
                        <img src="{ project.image }" alt="">
                        <div class="hover_content">
                            <div>
                                <h4>{ project.name }</h4>
                                <span>{ project.date }</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../../reducer'
        import EventStore from '../../eventStore'

        this.viewModel = {
            projects: []
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
                    if(eventStore) {
                        let state = reduce(eventStore.events);

                        this.viewModel.projects = state.projects;

                        this.update(this.viewModel);
                    }
                }
            });
        };

        subscribe('projects', 'app.update.projects');
    </script>
</work-area>
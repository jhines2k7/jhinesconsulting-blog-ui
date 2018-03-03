<project-detail>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite"></div>
    <!--02.InnerPage Area End-->
    <!--03.WorkPage Area Start-->
    <div class="work_page_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <div class="work_page_wraper">
                        <div class="row">
                            <div class="col-md-12"><img src="assets/img/work_banner.jpg" alt=""></div>
                            <div class="col-md-7">
                                <h2>Project Description</h2>
                                <problem></problem>
                            </div>
                            <div class="col-md-5">
                                <ul class="work_data">
                                    <li>
                                        <span class="bold">Project Name</span>
                                        <span>{ viewModel.project.name }</span>
                                    </li>
                                    <li>
                                        <span class="bold">Client</span>
                                        <span>{ viewModel.project.client }</span>
                                    </li>
                                    <li>
                                        <span class="bold">Date</span>
                                        <span>{ viewModel.project.date }</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-12">
                                <div class="resume_margin_top">
                                    <h2>Solution</h2>
                                    <solution></solution>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--03.WorkPage Area End-->
    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {
            project: {}
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

                    if(state.currentView !== 'projectDetail') {
                        this.unmount();
                    } else {
                        this.viewModel.project = state.project;

                        riot.tag('problem', '<span></span>', function(opts) {
                            if(opts.r) {
                                this.root.innerHTML = opts.r;
                            }
                        });

                        riot.mount('problem', {
                            r: state.project.problem
                        });

                        riot.tag('solution', '<span></span>', function(opts) {
                            if(opts.r) {
                                this.root.innerHTML = opts.r;
                            }
                        });

                        riot.mount('solution', {
                            r: state.project.solution
                        });

                        eventStore.add(eventStore.events, [{
                            channel: 'routing',
                            topic: 'app.update.innerPage',
                            data: state.project.name
                        }]);

                        this.update(this.viewModel);
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('routing', 'app.update.project');
    </script>
</project-detail>
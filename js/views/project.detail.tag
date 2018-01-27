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
                                <p>Markab did increasing occasional toem itsn dificulty and especiay known ama tiled bue sorry bed sudden manner edeed now feebly face doen with emmem need of wife paid that beme applauded or favourite dashwoods therefore up distrusts knowledge certainly day sweetness.</p>
                                <p>Markab did increasing occasional toem itsn dificulty and especiay known ama tiled bue sorry bed sudden manner edeed now feebly face doen with emmem need of wife paid that beme applauded.</p>
                            </div>
                            <div class="col-md-5">
                                <ul class="work_data">
                                    <li>
                                        <span class="bold">Project naame</span>
                                        <span>Branding Design</span>
                                    </li>
                                    <li>
                                        <span class="bold">Client</span>
                                        <span>David Roman</span>
                                    </li>
                                    <li>
                                        <span class="bold">Duration</span>
                                        <span>02 Months</span>
                                    </li>
                                    <li>
                                        <span class="bold">Date</span>
                                        <span>02 March, 2017</span>
                                    </li>
                                    <li>
                                        <span class="bold">Budject</span>
                                        <span>$350</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-12">
                                <div class="resume_margin_top">
                                    <h2>Solution of this project</h2>
                                    <p>Markab did increasing occasional toem itsn dificulty and especiay known knows that ama tiled in sorry edeed now feebly face doen withe need of wife paid that beme applauded or favourite dashwoods therefore up distrusts knowledge certainly day sweetness evil soon high in hope do few northward believing attempted. Yet timed being songs marry one defer men our.
                                    </p>
                                    <p>Markab did increasing occasional toem itsn dificulty and especiay known knows that ama tiled in sorry edeed now feebly face doen withe need of wife paid that beme applauded or favourite dashwoods therefore up distrusts knowledge certainly day sweetness evil soon high in hope do few northward believing attempted. Yet timed being songs marry one defer men our.
                                    </p>
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

        this.viewModel = {};

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
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</project-detail>
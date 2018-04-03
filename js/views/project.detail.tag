<project-detail>
    <!--02.InnerPage Area Start-->
    <div data-is="inner-page" class="inner_page_area background_ofwhite" style="background-image: url({ bannerImage });background-blend-mode: color-burn"></div>
    <!--02.InnerPage Area End-->
    <!--03.WorkPage Area Start-->
    <div class="work_page_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <div class="work_page_wraper">
                        <div data-is={ component }></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--03.WorkPage Area End-->
    <!--05.ContactPage Area Start-->
    <div data-is="contact-area" class="contact_area"></div>
    <!--05.ContactPage Area End-->
    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.component = '';
        this.bannerImage = '';

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
                        this.component = state.project.slug;
                        this.bannerImage = state.project.bannerImage;

                        eventStore.add(eventStore.events, [{
                            channel: 'routing',
                            topic: 'app.update.innerPage',
                            data: state.project.name
                        }]);

                        this.update();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
        subscribe('routing', 'app.update.project');
    </script>
</project-detail>
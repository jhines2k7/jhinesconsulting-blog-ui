<skill-ratings>
    <div class="progress_bar_wraper">
        <div class="single_skill">
            <div id="bar1" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage={ viewModel.problemDecompositionRating }></span>
            </div>
            <div class="skill_title">
                <span>PROBLEM DECOMPOSITION</span>
            </div>
        </div>
        <div class="single_skill">
            <div id="bar2" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage={ viewModel.systemsDecompositionRating }></span>
            </div>
            <div class="skill_title">
                <span>SYSTEMS DECOMPOSITION</span>
            </div>
        </div>
        <div class="single_skill">
            <div id="bar3" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage={ viewModel.communicationRating }></span>
            </div>
            <div class="skill_title">
                <span>COMMUNICATION</span> (I can always be a better listener...)
            </div>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../../reducer'
        import EventStore from '../../eventStore'

        this.currentView = '';

        this.viewModel = {
            problemDecompositionRating: 0,
            systemsDecompositionRating: 0,
            communicationRating: 0
        };

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        this.on('updated', () => {
            //waypoint
            if(this.currentView === 'about') {
               updateSkillRatingBars()
            } else {
                if ($.fn.waypoint) {
                    $('.progress_bar_wraper').waypoint(function() {
                        updateSkillRatingBars()
                    }, {
                        offset: '75%'
                    });
                }
            }
        });

        let updateSkillRatingBars = () => {
            let progressColor = "#1C48F3";

            //progressbar
            $('#bar1').barfiller({
                barColor: progressColor
            });
            $('#bar2').barfiller({
                barColor: progressColor
            });
            $(' #bar3').barfiller({
                barColor: progressColor
            });
            $(' #bar4').barfiller({
                barColor: progressColor
            });
        };

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    this.currentView = state.currentView;

                    this.viewModel.problemDecompositionRating = 93;
                    this.viewModel.systemsDecompositionRating = 96;
                    this.viewModel.communicationRating = 90;

                    this.update();
                }
            });
        };

        subscribe('routing', 'app.update.currentView');

    </script>
</skill-ratings>
<skill-ratings>
    <div class="progress_bar_wraper">
        <div class="single_skill">
            <div id="bar1" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage="80"></span>
            </div>
            <div class="skill_title">
                <span>UI/UX DESIGN</span>
            </div>
        </div>
        <div class="single_skill">
            <div id="bar2" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage="85"></span>
            </div>
            <div class="skill_title">
                <span>GRAPHIC DESIGN</span>
            </div>
        </div>
        <div class="single_skill">
            <div id="bar3" class="barfiller">
                <span class="tip"></span>
                <span class="fill" data-percentage="80"></span>
            </div>
            <div class="skill_title">
                <span>MEDIA MARKETING</span>
            </div>
        </div>
    </div>

    <script>
        this.on('mount', () => {
            //waypoint
            if ($.fn.waypoint) {
                $('.progress_bar_wraper').waypoint(function() {
                    var progressColor = "#1C48F3";
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
                }, {
                    offset: '75%'
                });
            }
        });
    </script>
</skill-ratings>
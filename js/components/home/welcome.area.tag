<welcome-area>
    <div class="welcome_area">
        <div class="display_flex">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-md-offset-1 text-center">
                        <div class="welcome_content">
                            <h1>
                                <div class="typewrite">
                                    { viewModel.greetingText }
                                    <span class="blinking-cursor">|</span>
                                </div>
                            </h1>
                            <span class="wrap"></span>
                            <p>Compass prepare and easoable size now easy eat hand emma mere dection atten heart amar amd mosems murse means.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        this.viewModel = {
            greetingText: ''
        };

        this.on('mount', () => {
            type();

            this.update();
        });

        let type = () => {
            let greetingText = 'Hello, I\'m James. Pleased to meet you!';
            let delta = 500;

            greetingText.split("").forEach((character) => {
                setTimeout(() => {
                    this.viewModel.greetingText = this.viewModel.greetingText + character;
                    this.update();
                }, delta);

                delta += 500;
            });
        }
    </script>
</welcome-area>
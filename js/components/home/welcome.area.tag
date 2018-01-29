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
            type('Hello, I\'m James. Pleased to meet you!')
                .then(erase)
                .then(type('Would you like to hear a joke?'));
        });

        let erase = () => {
            return new Promise((resolve) => {
                let delta = 1500;

                for(let i = 0; i < this.viewModel.greetingText.length; i++) {
                    setTimeout(() => {
                        this.viewModel.greetingText = this.viewModel.greetingText.slice(0, -1);
                        this.update();
                    }, delta);

                    delta += 50;
                }

                setTimeout(() => {
                    resolve();
                }, delta);
            });
        };

        let type = (text) => {
            return new Promise((resolve) => {
                let delta = 1250;

                text.split("").forEach( (character) => {
                    setTimeout(() => {
                        this.viewModel.greetingText = this.viewModel.greetingText + character;
                        this.update();
                    }, delta);

                    delta += 100;
                });

                setTimeout(() => {
                    resolve();
                }, delta);
            });
        }
    </script>
</welcome-area>
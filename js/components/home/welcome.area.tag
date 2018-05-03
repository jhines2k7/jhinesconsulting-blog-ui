<welcome-area>
    <div class="welcome_area">
        <div class="display_flex">
            <div class="container">
                <div class="row welcome-flex">
                    <div class="col-md-6 col-md-offset-1 col-sm-9 col-xs-6 text-center">
                        <div class="welcome_content">
                            <h1>
                                <div class="typewrite">
                                    { viewModel.greetingText }
                                    <span class="blinking-cursor">|</span>
                                </div>
                            </h1>
                            <p>
                                I'm a Data Solutions Architect and IT Consultant. I can help your small or mid-sized business make
                                sense of one of the most valuable resources you have: YOUR DATA!
                            </p>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="call-to-action">
                            <a href=#/contact class="custom_btn tall_btn">Contact me for a FREE consultation</a>
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
            type("Hello, I'm James. Pleased to meet you!")
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type)
                .then(erase)
                .then(type);
        });

        let banter = [
            "I'm a Data Solutions Architect and IT Consultant.",
            "What areas of your business would you like to improve?",
            "Understanding customer behavior?",
            "Operational efficiency?",
            "Social media sentiment analysis and response?",
            "Tailored and targeted messaging?",
            "I could keep going... ",
            "...but I think you get the idea.",
            "Please have a look around...",
            "...and don't forget to hire me for your next project!"
        ];

        let erase = () => {
            return new Promise((resolve) => {
                let delta = 1500;

                for(let i = 0; i < this.viewModel.greetingText.length; i++) {
                    setTimeout(() => {
                        this.viewModel.greetingText = this.viewModel.greetingText.slice(0, -1);
                        this.update();
                    }, delta);

                    delta += 25;
                }

                setTimeout(() => {
                    resolve(banter.shift());
                }, delta);
            });
        };

        let type = (text) => {
            return new Promise((resolve) => {
                let delta = 1250;

                text.split("").forEach((character) => {
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
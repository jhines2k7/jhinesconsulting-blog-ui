<contact-form>
    <div class="contact_form">
        <div if={ !viewModel.showContactFormSuccess } class="section_tittle">
            <h1>Get in touch</h1>
        </div>
        <form if={ !viewModel.showContactFormSuccess } onsubmit={ submit }>
            <div class="input">
                <input ref="name" type="text" name="name" placeholder="Name">
            </div>
            <div class="input">
                <input ref="email" type="email" name="email" placeholder="Email" required>
            </div>

            <p>What areas of your business would you like to improve?</p>

            <div class="business-area-checkbox">
                <input type="checkbox" value="Understanding customer behavior" ref="understandCustomers">
                <p>Understanding customer behavior</p>
            </div>

            <div class="business-area-checkbox">
                <input type="checkbox" value="Operational efficiency" ref="opEfficiency">
                <p>Operational efficiency</p>
            </div>

            <div class="business-area-checkbox">
                <input type="checkbox" value="Social media sentiment analysis and response" ref="socialMediaAnalysis">
                <p>Social media sentiment analysis and response</p>
            </div>

            <div class="business-area-checkbox">
                <input type="checkbox" value="Tailored and targeted messaging" ref="targetedMessaging">
                <p>Tailored and targeted messaging</p>
            </div>

            <div class="business-area-checkbox">
                <input type="checkbox" value="Other" ref="other">
                <p>Other</p>
            </div>

            <div class="form_btn">
                <button if={ !viewModel.requestInProgress } type="submit" class="custom_btn">Submit<i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>

                <div if={ viewModel.requestInProgress } class="svg-container">
                    <img src="assets/img/Bars-1s-200px.svg" alt="">
                </div>

                <div if={ viewModel.showContactFormError && !viewModel.requestInProgress } class="form-submission-error">
                    <p>The server encountered an internal error while processing your form submission.</p>
                    <p>Try again later or send an email to: <a href="mailto:support@jhinesconsulting.com">support@jhinesconsulting.com</a></p>
                </div>

                <div if={ viewModel.showConnectionError && !viewModel.requestInProgress } class="form-submission-error">
                    <p>There was a problem contacting the server.</p>
                    <p>Try again later or send an email to: <a href="mailto:support@jhinesconsulting.com">support@jhinesconsulting.com</a></p>
                </div>
            </div>
        </form>

        <div if={ viewModel.showContactFormSuccess } class="contact-form-success important_content">
            <h2>Thank you!</h2>
            <h3>
                I'm thrilled to hear from you. I’ll get back to you very soon. Have a look around, and please feel free to take a look at some of the articles in my
                <a href="#/blog"> blog</a>.
            </h3>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import EventStore from '../eventStore'
        import initialize from '../initializeMap'
        import config from '../config'

        this.viewModel = {
            showContactFormSuccess: false,
            showConnectionError: false,
            showContactFormError: false,
            requestInProgress: false
        };

        let eventStore = null;

        const clientID = config.clientID;

        let eventSource = new EventSource(`${config.contactFormDomain}/events/contactsaved/${clientID}`, {});

        let handleContactSaved = (e) => {
            eventStore.add(eventStore.events, [{
                channel: 'api-requests',
                topic: 'app.form.submission.success'
            }]);
        };

        this.on('mount', () => {
            eventStore = new EventStore();

            //Form Focus
            let forminput = $(".contact_form form .input,.contact_form form .textarea");
            forminput.on("focusin", () => {
                forminput.removeClass("active");
                $(this).addClass("active");
            });

            eventSource.addEventListener(`contact-saved-${clientID}`, handleContactSaved, false);
        });

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let currentTopic = envelope.topic;

                    if(currentTopic === 'app.form.submission.success') {
                        this.viewModel.showContactFormSuccess = true;
                    } else if(currentTopic === 'app.form.submission.failure') {
                        this.viewModel.showContactFormError = true;
                        this.viewModel.requestInProgress = false;
                    } else if (currentTopic === 'app.connection.error') {
                        this.viewModel.showConnectionError = true;
                        this.viewModel.requestInProgress = false;
                    }

                    this.update(this.viewModel);
                }
            });
        };

        subscribe('api-requests', 'app.form.submission.success');
        subscribe('api-requests', 'app.form.submission.failure');
        subscribe('api-requests', 'app.connection.error');

        submit(e) {
            console.log(`EventSource.readyState: ${eventSource.readyState}`);

            if(eventSource.readyState === 2) {
                eventSource = new EventSource(`${config.contactFormDomain}/events/contactsaved/${clientID}`, {});

                eventSource.removeEventListener(`contact-saved-${clientID}`, handleContactSaved, false);

                eventSource.addEventListener(`contact-saved-${clientID}`, handleContactSaved, false);
            }

            e.preventDefault();

            this.viewModel.requestInProgress = true;
            this.viewModel.showConnectionError = false;
            this.viewModel.showContactFormError = false;

            this.update(this.viewModel);

            let businessAreas = [
                this.refs.understandCustomers,
                this.refs.opEfficiency,
                this.refs.socialMediaAnalysis,
                this.refs.targetedMessaging,
                this.refs.other
            ];

            let filteredBusinessAreas = businessAreas.filter(area => area.checked).map(area => area.value);

            let data = {
                clientID: clientID,
                name: this.refs.name.value,
                email: this.refs.email.value,
                businessAreas: filteredBusinessAreas
            };

            fetch(`${config.contactFormDomain}/contact`, {
                method: 'POST',
                body: JSON.stringify(data),
                headers: new Headers({
                    'Content-Type': 'application/json'
                })
            }).then(response => {
                if(!response.ok) {
                    throw new Error('The request to the server was not successful');
                }
            }).catch(error => {
                if(error.message === 'Failed to fetch') {
                    eventStore.add(eventStore.events, [{
                        channel: 'api-requests',
                        topic: 'app.connection.error'
                    }]);
                } else {
                    eventStore.add(eventStore.events, [{
                        channel: 'api-requests',
                        topic: 'app.form.submission.failure'
                    }]);
                }
            })
        }
    </script>
</contact-form>
<contact-form>
    <div class="contact_form">
        <div if={ !viewModel.showContactFormSuccess } class="section_tittle">
            <h1>Get in touch</h1>
        </div>
        <form if={ !viewModel.showContactFormSuccess } onsubmit={ submit }>
            <div class="input">
                <input ref="name" type="text" name="name" placeholder="Name here">
            </div>
            <div class="input">
                <input ref="email" type="email" name="email" placeholder="Email here" required>
            </div>
            <div class="textarea">
                <textarea ref="message" name="message" placeholder="Message here"></textarea>
            </div>
            <div class="form_btn">
                <button type="submit" class="custom_btn">Submit<i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>
                <div if={ viewModel.showContactFormError } class="form-submission-error">
                    <p>The server encountered an internal error while processing your form submission.</p>
                    <p>Try again later or send an email to: <a href="mailto:support@jhinesconsulting.com">support@jhinesconsulting.com</a></p>
                </div>

                <div if={ viewModel.showConnectionError } class="form-submission-error">
                    <p>There was a problem contacting the server.</p>
                    <p>Try again later or send an email to: <a href="mailto:support@jhinesconsulting.com">support@jhinesconsulting.com</a></p>
                </div>
            </div>
        </form>

        <div if={ viewModel.showContactFormSuccess } class="contact-form-success important_content">
            <h3>
                Dissuade estatic and properly sawen entire sorrow delight endeavor
                onemy moen eto horrible margaret suitable followed general speed
                deed vanity excuse amarm are lover offer scale.
            </h3>
        </div>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import EventStore from '../../eventStore'
        import initialize from '../../initializeMap'
        import config from '../../config'

        this.viewModel = {
            showContactFormSuccess: false,
            showConnectionError: false,
            showContactFormError: false
        };

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();

            //Form Focus
            var forminput = $(".contact_form form .input,.contact_form form .textarea");
            forminput.on("focusin", function() {
                forminput.removeClass("active");
                $(this).addClass("active");
            });
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
                    } else if (currentTopic === 'app.connection.error') {
                        this.viewModel.showConnectionError = true;
                    }

                    this.update(this.viewModel);
                }
            });
        };

        subscribe('api-requests', 'app.form.submission.success');
        subscribe('api-requests', 'app.form.submission.failure');
        subscribe('api-requests', 'app.connection.error');

        submit(e) {
            e.preventDefault();

            let url = `http://${config.domain}/contact`;
            let data = {
                name: this.refs.name.value,
                email: this.refs.email.value,
                message: this.refs.message.value
            };

            fetch(url, {
                method: 'POST',
                body: JSON.stringify(data),
                headers: new Headers({
                    'Content-Type': 'application/json'
                })
            }).then(response => {
                if(response.ok) {
                    return response.json();
                }

                throw new Error('The request to the server was not successful');
            }).then(response => {
                eventStore.add(eventStore.events, [{
                    channel: 'api-requests',
                    topic: 'app.form.submission.success'
                }]);
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
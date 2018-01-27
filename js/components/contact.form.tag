<contact-form>
    <div class="contact_form">
        <div class="section_tittle">
            <h1>Get in touch</h1>
        </div>
        <form action="https://formspree.io/crazycafe@gmail.com" method="POST">
            <div class="input">
                <input type="text" name="name" placeholder="Name here">
            </div>
            <div class="input">
                <input type="email" name="email" placeholder="Email here" required>
            </div>
            <div class="textarea">
                <textarea name="message" placeholder="Message here"></textarea>
            </div>
            <div class="form_btn">
                <button type="submit" class="custom_btn">Submit<i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>
            </div>
        </form>
    </div>

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'
        import initialize from '../initializeMap'

        this.viewModel = {};

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
    </script>
</contact-form>
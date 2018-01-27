<contact-map>
    <div class="map" id="googleMap"></div>

    <script>
        import initialize from '../../initializeMap'

        this.on('mount', () => {
            initialize()
        });
    </script>
</contact-map>
export default function initialize() {
    let myCenter = new google.maps.LatLng(39.96137, -82.99863);

    let mapProp = {
        center: myCenter,
        scrollwheel: false,
        zoom: 12,
        zoomControl: false,
        mapTypeControl: false,
        streetViewControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: [{
            "featureType": "landscape",
            "stylers": [{
                "saturation": -100
            }, {
                "lightness": 65
            }, {
                "visibility": "on"
            }]
        }, {
            "featureType": "poi",
            "stylers": [{
                "saturation": -100
            }, {
                "lightness": 51
            }, {
                "visibility": "simplified"
            }]
        }, {
            "featureType": "road.highway",
            "stylers": [{
                "saturation": -100
            }, {
                "visibility": "simplified"
            }]
        }, {
            "featureType": "road.arterial",
            "stylers": [{
                "saturation": -100
            }, {
                "lightness": 30
            }, {
                "visibility": "on"
            }]
        }, {
            "featureType": "road.local",
            "stylers": [{
                "color": "#F2F2F2"
            }, {
                "visibility": "off"
            }]
        }, {
            "featureType": "transit",
            "stylers": [{
                "saturation": -100
            }, {
                "visibility": "simplified"
            }]
        }, {
            "featureType": "administrative.province",
            "stylers": [{
                "visibility": "off"
            }]
        }, {
            "featureType": "water",
            "elementType": "labels",
            "stylers": [{
                "visibility": "on"
            }, {
                "color": "#F2F2F2"
            }]
        }, {
            "featureType": "water",
            "elementType": "geometry",
            "stylers": [{
                "color": "#DFDFDF"
            }, {
                "visibility": "on"
            }]
        }]
    };

    let map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

    let marker = new google.maps.Marker({
        position: myCenter,
        icon: 'assets/img/mapicon.png',
        animation: google.maps.Animation.BOUNCE,

    });
    marker.setMap(map);
}
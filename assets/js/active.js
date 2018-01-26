(function($) {
    "use strict";
    jQuery(document).ready(function() {
        //Form Focus
        var forminput = $(".contact_form form .input,.contact_form form .textarea");
        forminput.on("focusin", function() {
            forminput.removeClass("active");
            $(this).addClass("active");
        });
        // All slider activation
        if ($.fn.owlCarousel) {
            //==welcome_area==\\
            $('.home3_welcome_slider').owlCarousel({
                items: 1,
                loop: true,
                smartSpeed: 500,
                autoplay: true,
                mouseDrag: false,
                touchDrag: false,
                dots: true
            });
            //==welcome_area animation==\\
            $(".home3_welcome_slider").on('translate.owl.carousel', function() {
                $('.welcome_content h1').removeClass('fadeInLeft animated').hide();
                $('.welcome_content p').removeClass('fadeInLeft animated').hide();
                $('.welcome_content a').removeClass('fadeInLeft animated').hide();
            });
            $(".home3_welcome_slider").on('translated.owl.carousel', function() {
                $('.owl-item.active .welcome_content h1').addClass('fadeInLeft animated').show();
                $('.owl-item.active .welcome_content p').addClass('fadeInLeft animated').show();
                $('.owl-item.active .welcome_content a').addClass('fadeInLeft animated').show();
            });
            //Testimonial Slider
            $('.testimonial_slider').owlCarousel({
                items: 1,
                loop: true,
                nav: false,
                autoplay:true
            })
            $('.home4_testimonial_slider').owlCarousel({
                    margin: 45,
                    loop: true,
                    dots: false,
                    nav: false,
                    autoplay:true,
                    responsive: {
                        0: {
                            items: 1
                        },
                        992: {
                            items: 2
                        }
                    }
                })
                //==Work_slider==\\
            $('.work_slider').owlCarousel({
                margin: 35,
                loop: true,
                autoplay: true,
                dots: false,
                nav: false,
                responsive: {
                    0: {
                        items: 1
                    },
                    480: {
                        items: 2,
                        margin: 10
                    },
                    768: {
                        items: 3
                    },
                    992: {
                        items: 5,
                        margin: 10
                    }
                }
            });
        };
        //Nav
        if($.fn.onePageNav){
            $('.main_menu').onePageNav({
                changeHash: false,
                scrollSpeed: 750,
                scrollThreshold: 0,
                filter: '',
                easing: 'swing'
            });
        }
        //Mobile Nav
        if ($.fn.slicknav) {
            $('.main_menu').slicknav({
                label: '',
                prependTo: ".menu_bar"
            });
        };
        // video popup
        if ($.fn.magnificPopup) {
            $(".popup_video").magnificPopup({
                type: 'iframe',
                mainClass: 'mfp-fade'
            });
        };

        //Filter isotope
        if ($.fn.isotope) {
            //project isotope
            $('.isotope_menu li').click(function() {

                $(".isotope_menu li").removeClass("active");
                $(this).addClass("active");

                var selector = $(this).attr('data-name');
                $(".isotope").isotope({
                    filter: selector,
                    animationOptions: {
                        duration: 750,
                        easing: 'linear',
                        queue: false
                    }
                });
                return false;
            });
        };
    });

    jQuery(window).on("load", function() {
        //Isotpe active
        if ($.fn.isotope) {
            $(".isotope").isotope({
                itemSelector: '.single_work_wraper',
                layoutMode: 'fitRows'
            });
        };
        // preloader
        $('.preloader,.pace').fadeOut(1500);
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

})(jQuery);

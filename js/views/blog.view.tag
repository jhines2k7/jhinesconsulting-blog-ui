<blog>
    <!--02.InnerPage Area Start-->
    <inner-page></inner-page>
    <!--02.InnerPage Area End-->
    <!--03.BlogPage Area Start-->
    <div class="blog_page_area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-lg-9 col-sm-7">
                    <div class="blog_wraper">
                        <div class="single_blog">
                            <img src="assets/img/blog1.jpg" alt="">
                            <h3>Man travels around the world in 80 awesome selfie</h3>
                            <span class="blog_meta">Rubel Hossen / 22 December, 2017</span>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make.</p>
                            <a href="single_blog.html" class="custom_btn">Read more</a>
                        </div>
                        <div class="single_blog">
                            <img src="assets/img/blog2.jpg" alt="">
                            <h3>Man travels around the world in 80 awesome selfie</h3>
                            <span class="blog_meta">Rubel Hossen / 22 December, 2017</span>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make.</p>
                            <a href="single_blog.html" class="custom_btn">Read more</a>
                        </div>
                        <div class="single_blog">
                            <img src="assets/img/blog3.jpg" alt="">
                            <h3>Man travels around the world in 80 awesome selfie</h3>
                            <span class="blog_meta">Rubel Hossen / 22 December, 2017</span>
                            <p>Markab did increasing occasional toem itsn dificulty far espem sorry bed sudden manner edeed fat now feebly face do with that beme applaue ded or favourite dashwoods therefore distu ained perce end knowl etract yet delight written an farther his general bred at dare rose lose good and make.</p>
                            <a href="single_blog.html" class="custom_btn">Read more</a>
                        </div>
                    </div>
                    <div class="text-left">
                        <div class="pagination">
                            <a class="active" href="#">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-5">
                    <div class="blog_widget_wraper">
                        <div class="single_blog_widget search_bar">
                            <form>
                                <input type="text">
                                <button type="submit">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </button>
                            </form>
                        </div>
                        <div class="single_blog_widget post_category">
                            <div class="blog_widget_tittle">
                                <h3>Post Category</h3>
                            </div>
                            <ul>
                                <li><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i>Graphic Design</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i>Brand and Identity</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i>Online Marketing</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i>Web Development</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right" aria-hidden="true"></i>Social Media Marketing</a></li>
                            </ul>
                        </div>
                        <div class="single_blog_widget recent_post">
                            <div class="blog_widget_tittle">
                                <h3>Recent Post</h3>
                            </div>
                            <div class="single-recent_post">
                                <a href="#">Richard Norton is winning over are critics again</a>
                                <span class="blog_meta">22 December, 2017</span>
                            </div>
                            <div class="single-recent_post">
                                <a href="#">Richard Norton is winning over are critics again</a>
                                <span class="blog_meta">22 December, 2017</span>
                            </div>
                            <div class="single-recent_post">
                                <a href="#">Richard Norton is winning over are critics again</a>
                                <span class="blog_meta">22 December, 2017</span>
                            </div>
                            <div class="single-recent_post">
                                <a href="#">Richard Norton is winning over are critics again</a>
                                <span class="blog_meta">22 December, 2017</span>
                            </div>
                        </div>
                        <div class="single_blog_widget popular_tag">
                            <div class="blog_widget_tittle">
                                <h3>Popular Tag</h3>
                            </div>
                            <div class="tag">
                                <a href="#">Design</a>
                                <a href="#">Personal</a>
                                <a href="#">Branding</a>
                                <a href="#">Consulting</a>
                                <a href="#">ui/ux design</a>
                                <a href="#">Template</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--03.BlogPage Area End-->

    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();
        });

        let subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: (data, envelope) => {
                    let state = reduce(eventStore.events);

                    if(state.currentView !== 'blog') {
                        this.unmount();
                    }
                }
            });
        };

        subscribe('routing', 'app.update.currentView');
    </script>
</blog>
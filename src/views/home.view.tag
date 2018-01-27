<home>


    <script>
        import postal from 'postal/lib/postal.lodash'
        import reduce from '../reducer'
        import EventStore from '../eventStore'

        this.viewModel = {};

        let eventStore = null;

        this.on('mount', () => {
            eventStore = new EventStore();            
        });

        subscribe = (channel, topic) => {
            return postal.subscribe({
                channel: channel,
                topic: topic,
                callback: function(data, envelope) {
                    let state = reduce(eventStore.events);
                                        
                    if(state.currentView !== 'home') {
                        this.unmount();
                    } else {

                        this.viewModel.user = state.user;
                        this.viewModel.user.firstName = state.user.name.split(' ')[0];

                        this.viewModel.bounceRate = state.bounceRate;
                        this.viewModel.location = state.location;
                        this.viewModel.comments = state.comments;
                        this.viewModel.visitors = state.visitors;
                        this.viewModel.productsSold = state.productsSold; 

                        this.update(this.viewModel);
                    }
                }.bind(this)
            });
        };

        this.subscribe('routing', 'admin.update.currentView');
        this.subscribe('routing', 'admin.update.home');

        this.on('updated', () => {
            var lineChart = document.getElementById('line-chart');

            var lineData = {
                labels: ["10", "20", "30", "40", "50", "60", "70"],
                datasets: [{
                    label: "Visitors Graph",
                    fill: false,
                    lineTension: 0,
                    backgroundColor: "#fff",
                    borderColor: "#6896f9",
                    borderCapStyle: 'butt',
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: 'miter',
                    pointBorderColor: "#fff",
                    pointBackgroundColor: "#2a2f37",
                    pointBorderWidth: 3,
                    pointHoverRadius: 10,
                    pointHoverBackgroundColor: "#FC2055",
                    pointHoverBorderColor: "#fff",
                    pointHoverBorderWidth: 3,
                    pointRadius: 6,
                    pointHitRadius: 10,
                    data: [5, 32, 5, 42, 50, 59, 11],
                    spanGaps: false
                }]
            };

            var myLineChart = new Chart(lineChart, {
                type: 'line',
                data: lineData,
                options: {
                    legend: {
                        display: false
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                fontSize: '11',
                                fontColor: '#969da5'
                            },
                            gridLines: {
                                color: 'rgba(0,0,0,0.05)',
                                zeroLineColor: 'rgba(0,0,0,0.05)'
                            }
                        }],
                        yAxes: [{
                            display: false,
                            ticks: {
                                beginAtZero: true,
                                max: 65
                            }
                        }]
                    }
                }
            });

            var donutChart = document.getElementById('donut-chart');
            var data = {
                labels: ["Red", "Yellow", "Green", "Blue"],
                datasets: [{
                    data: [80, 120, 80, 50],
                    backgroundColor: ["#ff4141", "#FBC02D", "#71c21a", "#5797fc"],
                    hoverBackgroundColor: ["#ff5c5c", "#fdcd54", "#89da32", "#6ca4fb"],
                    borderWidth: 0
                }]
            };

            new Chart(donutChart, {
                type: 'doughnut',
                data: data,
                options: {
                    legend: {
                        display: false
                    },
                    animation: {
                        animateScale: true
                    },
                    cutoutPercentage: 80
                }
            });

            // Jquery count to
            $('.timer').each(function() {
                $(this).countTo({
                    speed: 2000,
                    formatter: function (value, options) {
                        return value.toFixed(options.decimals).replace(/\B(?=(?:\d{3})+(?!\d))/g, ',')
                    }
                })
            })
        })                 
    </script>
</home> 

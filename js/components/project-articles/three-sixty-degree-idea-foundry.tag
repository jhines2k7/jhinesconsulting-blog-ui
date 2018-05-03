<three-sixty-degree-idea-foundry>
    <div class="row">
        <div class="col-md-12"><img src="assets/img/iflogohires.png" alt=""></div>
        <div class="col-md-7">
            <h2>Project Description</h2>
            <p>
                Idea Foundry data is scattered across many different sources and growing every day. What if there were
                a way to transform data from one or more of those sources into a format that makes it easier to create
                insights and derive business value from complex data? Our goal was to automate the real-time creation
                of records in MySQL databases from transformed data stored in the Occasion event management system.
            </p>
            <p>
                We were able to determine there was a need to make customer data accessible for business analytics and
                targeted marketing. The process of gathering information about the problem and a potential solution
                came about as a series of informal and formal conversations with some of the leadership at the Idea Foundry.
            </p>
        </div>
        <div class="col-md-5">
            <ul class="work_data">
                <li>
                    <span class="bold">Project Name</span>
                    <span>360-Degrees At The Idea Foundry</span>
                </li>
                <li>
                    <span class="bold">Client</span>
                    <span>Idea Foundry</span>
                </li>
            </ul>
        </div>
        <div class="col-md-12">
            <div class="resume_margin_top">
                <h2>Solution</h2>
                <p>
                    The recommendation for a software solution based upon the results we were seeking, given the
                    limitations, questions and issues uncovered during our discovery process was to migrate Occasion
                    data on demand as needed for reporting purposes. It was determined that a real-time streaming
                    solution would not be necessary. That way we could avoid the additional costs of running virtual
                    machines in the cloud 24/7. The infrastructure that enables these on demand migrations is 100% cloud
                    based. This allows us to control costs by not having to maintain any of the compute resources in
                    house. In addition, the infrastructure can be completely torn down and rebuilt as needed, so there
                    will be no charges incurred for compute power not in use.
                </p>
                <p>
                    The system uses Occasion’s RESTful API to get information about all orders placed by the Idea
                    Foundry’s customers. Using a combination of Java and Apache Kafka, the solution streams results
                    from requests to Occasion’s API and transforms them into rows in a MySQL database that
                    describe the who, what and when of the order being placed. From there, any number of reporting and
                    visualization tools can be used to answer questions that are of interest to the business.
                </p>
                <p>
                    Getting customer data from Occasion into a relational database is a great first step, but it’s only
                    one source of data. The solution is fully extendable and can accomodate any number of additional
                    source and target systems. As we integrate more source systems into the solution, we can gain
                    deeper insights into customer behavior and start to build a more robust model of an Idea Foundry member.
                </p>
            </div>
        </div>
    </div>
</three-sixty-degree-idea-foundry>
<setting-up-a-kafka-cluster-using-docker-swarm-1>
    <img src="assets/img/apache-kafka-logo.png" alt="">

    <h3>Setting Up A Highly Available Apache Kafka Cluster Using Docker Swarm: Part 1 of 2</h3>

    <span class="blog_meta">James Hines / March 16, 2018</span>

    <p>
        As businesses get more and more comfortable with the idea of microservice architectures, one of the most
        important decisions you’ll have to make is the way in which your services will communicate with each other.
        Async messaging is one approach you can take to solve this problem. While we won’t go into how you would
        <span class="font-italic">use</span> an async messaging system to facilitate communication between services in
        your application, we will look at a way to <span class="font-italic">deploy</span> an async messaging system to the cloud.
    </p>

    <h3>What is Apache Kafka?</h3>

    <p>
        Apache Kafka is a distributed streaming platform. For my purposes, this means that Kafka makes it easier to
        build and scale distributed applications that transfer data between systems and applications in real time.
        It’s a very mature project and among its many functionalities can be used as an async messaging system.
    </p>

    <p>
        Here’s a list of technologies we’ll be using in this article. You don’t have to be an expert, but you should
        have some experience working with the following:
    </p>

    <ul>
        <li>Linux operating systems</li>
        <li>Networking</li>
        <li>Docker</li>
        <li>Bash</li>
    </ul>

    <p>
        In this article I’ll be using Digital Ocean as my cloud provider, and I will be provisioning machines in the
        cloud. This means that if you follow along with me step by step you will occur charges for the compute time
        used by the machines you've provisioned.
    </p>

    <p>
        If you do want to be able follow along with me step by step, you’ll need to have access to the following:
    </p>

    <ul>
        <li>Digital Ocean account</li>
        <li>Digital Ocean access token</li>
        <li>A provisioned droplet with Docker and docker-machine installed</li>
    </ul>

    <p>
        You do not need a Digital Ocean account with a provisioned droplet installed in order to practice setting up a
        Kafka cluster. Your local dev machine with a Docker installation will do just fine. If you’re familiar with
        using docker-machine to create hosts on your local computer, you should have no trouble following along,
        although you won’t be able to follow along step by step.
    </p>

    <h3>Why Digital Ocean?</h3>

    <p>
        I decided to use DigitalOcean for this article because it's easier to get a system with multiple vms up and
        running on Digital Ocean than it is with AWS. With AWS you have to define virtual private clouds and security
        groups before you can provision any vms. Digital Ocean offers similar services, but they are not required in
        order to get up and running.
    </p>

    <p>
        I’m a big believer that developers should always be able to develop against environments with a network
        topology that’s identical to what will be used in production. So no localhost or 127.0.0.1 IP addresses. In
        addition, the entire application infrastructure for a production environment should be reproducible as we
        promote code from development through staging. The number of provisioned machines or application instances in
        dev, QA, or staging environments don’t need to match what’s in production, but the infrastructure should be
        identical. With on demand compute power available from any of several cloud providers, this is not an
        unreasonable thing to ask for... In my opinion, that means developing against vms running in a cloud
        environment, and isolate the service you're building. That means running an entire production environment on
        demand as you need it, with the exception of the service you're building. For the rest of this article I will
        be deploying to machines I have provisioned on demand in Digital Ocean.
    </p>

    <p>
        It’s been my experience that no one really knows the the actual state of completion of a software system
        until it's put into production. Therefore we should do everything in outr power to make sure we can make
        changes to the system as quickly and as smoothly as possible...
    </p>

    <p>Alright, rant over...</p>

    <h3>Let's get to it!</h3>

    <p>
        Here is a diagram of the network for our highly available Kafka cluster:
    </p>

    <img src="assets/img/ha-kafka-cluster-network-2.svg" alt="">

    <p>
        There are 6 virtual machines spread across 3 availability regions. Because we’ll be using Docker containers to
        run our ZooKeeper and Kafka services, we can take advantage of overlay networking to make container to
        container communication easier. It will not be necessary to expose any of the ports of our containers for the
        purposes of this article, as we can use dockerized consumers and producers to interact with our cluster.
    </p>

    <p>
        We’ll be using the docker-machine command to provision 6 dockerized vms that will be used to host our Kafka
        cluster. We’ll start with the ZooKeeper nodes, but let’s take some time to talk about ZooKeeper and its role
        in a Kafka cluster.
    </p>

    <h3>What is ZooKeeper?</h3>

    <p>
        ZooKeeper helps us coordinate tasks and processes in large distributed systems. It helps us overcome some of
        the assumptions we make when we are designing and building distributed systems. Assumptions such as network
        reliability, no latency, infinite bandwith to name a few. ZooKeeper also happens to be a hard dependency for
        Apache Kafka, so we've got to use it.
    </p>

    <p>ZooKeeper features:</p>

    <ul>
        <li>Distributed configuration management</li>
        <li>Self election/consensus building</li>
        <li>Coordination and locking</li>
        <li>Distributed key value store</li>
    </ul>

    <p>A few of ZooKeeper's responsibilities in an Apache Kafka cluster:</p>

    <ul>
        <li>Broker registration</li>
        <li>Maintains a list of Kafka topics along with topic configuration</li>
        <li>Performs leader election for Kafka brokers</li>
        <li>Stores the Kafka cluster id</li>
        <li>Stores Access Control Lists if you’ve enabled security</li>
    </ul>

    <p>We'll start by running the docker-machine commands to create the host for our ZooKeeper services:</p>

    <pre><code>
    $ docker-machine create \
        --engine-label "node.type=zknode1" \
        --driver digitalocean \
        --digitalocean-image ubuntu-17-10-x64 \
        --digitalocean-size 4gb \
        --digitalocean-access-token $DIGITALOCEAN_ACCESS_TOKEN \
        --digitalocean-region nyc1 \
        ZooKeeper1

    # These commands configure the Linux firewall for Docker Swarm
    $ docker-machine ssh ZooKeeper1 \
        echo '"y" | sudo ufw --force enable \
        && sudo ufw default deny incoming \
        && sudo ufw allow 22/tcp \
        && sudo ufw allow 2376/tcp \
        && sudo ufw allow 2377/tcp \
        && sudo ufw allow 7946/tcp \
        && sudo ufw allow 7946/udp \
        && sudo ufw allow 4789/udp \
        && sudo ufw allow 80/tcp \
        && sudo ufw reload \
        && sudo systemctl restart docker'

    $ docker-machine create \
        --engine-label "node.type=zknode2" \
        --driver digitalocean \
        --digitalocean-image ubuntu-17-10-x64 \
        --digitalocean-size 4gb \
        --digitalocean-access-token $DIGITALOCEAN_ACCESS_TOKEN \
        --digitalocean-region nyc3 \
        ZooKeeper2

    # These commands configure the Linux firewall for Docker Swarm
    $ docker-machine ssh ZooKeeper2 \
        echo '"y" | sudo ufw --force enable \
        && sudo ufw default deny incoming \
        && sudo ufw allow 22/tcp \
        && sudo ufw allow 2376/tcp \
        && sudo ufw allow 2377/tcp \
        && sudo ufw allow 7946/tcp \
        && sudo ufw allow 7946/udp \
        && sudo ufw allow 4789/udp \
        && sudo ufw allow 80/tcp \
        && sudo ufw reload \
        && sudo systemctl restart docker'

    $ docker-machine create \
        --engine-label "node.type=zknode3" \
        --driver digitalocean \
        --digitalocean-image ubuntu-17-10-x64 \
        --digitalocean-size 4gb \
        --digitalocean-access-token $DIGITALOCEAN_ACCESS_TOKEN \
        --digitalocean-region sfo2 \
        ZooKeeper3

    # These commands configure the Linux firewall for Docker Swarm
    $ docker-machine ssh ZooKeeper3 \
        echo '"y" | sudo ufw --force enable \
        && sudo ufw default deny incoming \
        && sudo ufw allow 22/tcp \
        && sudo ufw allow 2376/tcp \
        && sudo ufw allow 2377/tcp \
        && sudo ufw allow 7946/tcp \
        && sudo ufw allow 7946/udp \
        && sudo ufw allow 4789/udp \
        && sudo ufw allow 80/tcp \
        && sudo ufw reload \
        && sudo systemctl restart docker'
    </code></pre>

    <p>
        Because we will be deploying our services into a docker swarm, we need to designate one of the ZooKeeper
        nodes we’ve just created as swarm manager. Let's get the IP address of ZooKeeper1, then we'll use that in
        the command to init the swarm manager:
    </p>

    <pre><code>
    $ export SWARM_MANAGER_IP=$(docker-machine ip ZooKeeper1)

    $ docker-machine ssh ZooKeeper1 sudo docker swarm init --advertise-addr $SWARM_MANAGER_IP
    </code></pre>

    <p>
        Now that we've designated a manager for our swarm, we can add the two additional ZooKeeper nodes as workers by
        running these commands:
    </p>

    <pre><code>
    $ export JOIN_TOKEN=$(docker-machine ssh ZooKeeper1 sudo docker swarm join-token worker -q)

    $ docker-machine ssh ZooKeeper2 \
        sudo docker swarm join \
        --token $JOIN_TOKEN \
        $SWARM_MANAGER_IP:2377

    $ docker-machine ssh ZooKeeper3 \
        sudo docker swarm join \
        --token $JOIN_TOKEN \
        $SWARM_MANAGER_IP:2377
    </code></pre>

    <p>
        We've provisioned our machines and initiated a swarm. Let's create an overlay network that will allow
        our docker containers to communicate with each other:
    </p>

    <pre><code>
        $ eval "$(docker-machine env ZooKeeper1)"

        $ docker-machine ssh ZooKeeper1 docker network create -d overlay --attachable kafkanet
    </code></pre>

    <p>
        Now we can run the commands that will create our ZooKeeper services and run them in the swarm
    </p>

    <pre><code>
    $ docker service create \
        --network kafkanet \
        --name ZooKeeper1 \
        -e ZooKeeper_SERVER_ID=1 \
        -e ZooKeeper_CLIENT_PORT=22181 \
        -e ZooKeeper_TICK_TIME=2000 \
        -e ZooKeeper_INIT_LIMIT=5 \
        -e ZooKeeper_SYNC_LIMIT=2 \
        -e ZooKeeper_SERVERS="0.0.0.0:22888:23888;ZooKeeper2:32888:33888;ZooKeeper3:42888:43888" \
        --constraint "engine.labels.node.type==zknode1" \
        confluentinc/cp-ZooKeeper:4.0.0

    $ docker service create \
        --network kafkanet \
        --name ZooKeeper2 \
        -e ZooKeeper_SERVER_ID=2 \
        -e ZooKeeper_CLIENT_PORT=32181 \
        -e ZooKeeper_TICK_TIME=2000 \
        -e ZooKeeper_INIT_LIMIT=5 \
        -e ZooKeeper_SYNC_LIMIT=2 \
        -e ZooKeeper_SERVERS="ZooKeeper1:22888:23888;0.0.0.0:32888:33888;ZooKeeper3:42888:43888" \
        --constraint "engine.labels.node.type==zknode2" \
        confluentinc/cp-ZooKeeper:4.0.0

    $ docker service create \
        --network kafkanet \
        --name ZooKeeper3 \
        -e ZooKeeper_SERVER_ID=3 \
        -e ZooKeeper_CLIENT_PORT=42181 \
        -e ZooKeeper_TICK_TIME=2000 \
        -e ZooKeeper_INIT_LIMIT=5 \
        -e ZooKeeper_SYNC_LIMIT=2 \
        -e ZooKeeper_SERVERS="ZooKeeper1:22888:23888;ZooKeeper2:32888:33888;0.0.0.0:42888:43888" \
        --constraint "engine.labels.node.type==zknode3" \
        confluentinc/cp-ZooKeeper:4.0.0
    </code></pre>

    <p>
        Run the <span class="code">docker service ls</span> command to check the status of your services
    </p>

    <pre><code>
    $ docker service ls
    ID              NAME        MODE        REPLICAS    IMAGE                               PORTS
    ba833go46st2    ZooKeeper1  replicated  1/1         confluentinc/cp-ZooKeeper:4.0.0
    h3ke1cl29s6o    ZooKeeper2  replicated  1/1         confluentinc/cp-ZooKeeper:4.0.0
    a4c163jgwb79    ZooKeeper3  replicated  1/1         confluentinc/cp-ZooKeeper:4.0.0
    </code></pre>

    <p>
        Let's run a few commands to verify that our ZooKeeper ensemble is running properly. Your docker environment
        should still be pointing to the node we designated as manager, but these commands can be run from any of the
        nodes in your swarm:
    </p>

    <pre><code>
    $ docker run --net=kafkanet --rm confluentinc/cp-ZooKeeper:4.0.0 bash -c "echo stat | nc ZooKeeper1 22181 | grep Mode"
    $ docker run --net=kafkanet --rm confluentinc/cp-ZooKeeper:4.0.0 bash -c "echo stat | nc ZooKeeper2 32181 | grep Mode"
    $ docker run --net=kafkanet --rm confluentinc/cp-ZooKeeper:4.0.0 bash -c "echo stat | nc ZooKeeper3 42181 | grep Mode"
    </code></pre>

    <p>
        Those commands should display that you have one leader and two followers. As you can see, we can use docker
        containers to interact with our newly created ZooKeeper ensemble by setting a value for the <span class="code">--net</span>
        flag in our docker run command. This will come in very handy when we need to interact with our cluster from the command
        line. No need to expose the ports of our cluster to the public internet.
    </p>

    <p>
        So far, we've set up a ZooKeeper cluster on 3 independent nodes and 3 availability regions using Docker Swarm.
        In the second part of this article, we'll do the same with Kafka and take our new highly available cluster for a
        spin. Don't forget to destroy the Digital Ocean droplets you provisioned.
    </p>

    <pre><code>
    $ docker-machine rm -f zookeeper1 zookeeper2 zookeeper3
    </code></pre>

    <p>
        We'll pick up where we left off when we start part 2, and you can just run the commands from
        this article to set up your ZooKeeper ensemble.
    </p>
</setting-up-a-kafka-cluster-using-docker-swarm-1>
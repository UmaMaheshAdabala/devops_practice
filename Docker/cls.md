### DOCKER

    - As we use VM's to make our work scalabale and to reduce un wanted resources usage
    - To use them more efficiently upon VM's we use DOCKER
    - Docker is a containarization tool
    - Where we can write docker file and convert it into images and then it into container This is docker life cycle
    - Docker container is package/ combination of system dependencies, libraries, application

### Container---

    A container is a standard unit of software that packages up code and all its dependencies
    so the application runs quickly and reliably from one computing environment to another.
    A Docker container image is a lightweight, standalone, executable package of software that
    includes everything needed to run an application: code, runtime, system tools, system libraries
    and settings.
    A container is a bundle of Application, Application libraries required to run your application and the minimum
    system dependencies.

## Why containers are light weight---

    Containers are lightweight because they use a technology called containerization, which allows them
    to share the host operating system's kernel and libraries, while still providing isolation for the
    application and its dependencies. This results in a smaller footprint compared to traditional virtual
    machines, as the containers do not need to include a full operating system. Additionally, Docker
    containers are designed to be minimal, only including what is necessary for the application to run, f
    urther reducing their size.

    - so, in a nutshell, container base images are typically smaller compared to VM images because they are
     designed to be minimalist and only contain the necessary components for running a specific application
     or service. VMs, on the other hand, emulate an entire operating system, including all its libraries,
     utilities, and system files, resulting in a much larger size.

## First Basic Proz---

    - First create ec2 instance
    - Then ssh into instance by terminal
    - Then install docker
    - Then we have to add user to user  group to docker - sudo usermod -aG docker ubuntu
    - Then clone your repo
    - Then build the application
    - Then run the application

## Docker File Structure Basic---

- From ubuntu
- WORkDIR /app
- copy requirements to /app
- copy proz to /app
- RUN commands to downloads requirements
- ENTRYPOINT ["python3"] # we use main exutable here.
- CMD [" ", " ", " "] - Here the ENTRYPOINT and CMD are used for same purpose but difference is ENTRYPOINT cannot be changed from image But CMD commands can be chabged

## Multi Staged Docker Builds

    Till now we are using single stage docker build. So we are using an Image that has so many packages pre installed in it which are useless.
    So the docker image will be of more size. So we use Multi Stages where we choose a base image in the first stage and install all the required
    packages in the first stage and then we copy the binary into second stage the we use CMD here.
    So the image size is reduced alot.

    - Distorless images
    Basically this Distorless images are the images that only have minimalist packages they only have their specific runtime and more over they provide lot of security
    to the application

## Bind Mounts & Volumes

- There is a problem while using docker.
  It is a very common requirement to persist the data in a Docker container beyond the lifetime of the container.
  However, the file system of a Docker container is deleted/removed when the container dies. - There are 2 different ways how docker solves this problem.
  Volumes
  Bind Directory on a host as a Mount

      -- Bind Mounts
         - Bind Mounts means we can bind our file within a container to file in the host.
         - so we can access the file even the contaier goes down and file is not lost.
         - Using this way, user can mount a directory from the host file system into a container.
           Bind mounts have the same behavior as volumes, but are specified using a host path instead of a volume name.

      -- Volumes
          - Basically the volumes are the logical seperations on the host.
          - These volumes can be easily accesible by the containers

      * In a nutshell, Bind Directory on a host as a Mount are appropriate for simple use cases where you need to mount a directory from the host file system into a container,
        while volumes are better suited for more complex use cases where you need more control over the data being persisted in the container.

### Networking

Networking allows containers to communicate with each other and with the host system. Containers run isolated from the host system and need a
way to communicate with each other and with the host system.

    By default, Docker provides two network drivers for you, the bridge and the overlay drivers.

    -- Bridge N/W : The default network mode in Docker. It creates a private network between the host and containers, allowing containers
                   to communicate with each other and with the host system.
    -- Host N/W
        - This mode allows containers to share the host system's network stack, providing direct access to the host system's network.
        To attach a ho st network to a Docker container, you can use the --network="host" option when running a docker run command. When you use this option,
        the container has access to the host's network stack, and shares the host's network namespace. This means that the container will use the same IP address
        and network configuration as the host.
    -- Overlay N/W
        -This mode enables communication between containers across multiple Docker host machines, allowing containers to be connected to a single network even
         when they are running on different hosts.

    -- Create a container
        - docker run -d --name cont1 nginx:latest
    -- Create a N/W
        - docker network create <Name>
        - Create container with private bridge : -docker run -d --network=custom-n/w --name private nginx:latest

--- Total Cycle - Build the image → docker build -t my-image . - Create the container → docker create --name my-container my-image - Start the container → docker start my-container - Interact with it → docker exec -it my-container bash - Stop & remove when done → docker stop my-container && docker rm my-container

--- Diff b/w docker copy and docker add - Docker Add is used to copy files from URL's - Docker Copy only copies files from host system to container

--- Port mapping to a Container with a Host Container - Step 1: Create a custom bridge network → docker network create my-bridge-network - Step 2: Run the container with port mapping → docker run -d --network my-bridge-network -p 8080:80 my-image - Step 3: Verify with docker ps and docker network inspect - Step 4: Access via http://localhost:8080

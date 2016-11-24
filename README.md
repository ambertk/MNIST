A Docker Intro
==============

By Brian McIlwain and Wenxiu Hu

The goal of our project was to turn a raspberry pi into a Docker container server. To do this, I've selected a sample project that we will run, explain what is happening, and finally talk about why you would use Docker.

Getting Started
---------------

In order to run this on your own environment you will need one thing and one thing only: Docker. If you're running a typical desktop Mac/Linux/Windows you can install it at https://www.docker.com/products/docker. If you're trying this on a raspberry pi or command-line-only Linux environment you can install it by opening a terminal and typing

```bash
curl -sSL https://get.docker.com | sh
```

Running it
----------

Once you have Docker, if you have an x86-like machine you can run the project by typing

```bash
docker run bmcilw1/mnist
```

Or, on a raspberry pi or other ARM processor device

```bash
docker run bmcilw1/mnist:rpi

```

This will take a while the first run because it needs to fetch the container from your internet connection.

What just happened?
-------------------

What did NOT happen
-------------------

To begin to understand this, the first thing to realize is that running these commands did NOT actually install anything at all onto your computer. The only thing that was installed was Docker itself, which we did in step one. We just told Docker to run this thing, and it just worked.

So what is Docker?
---------------

Docker runs arbitrary code by running it in something called a container. I like the explanation found here: <https://blog.docker.com/2016/03/containers-are-not-vms/>. A container is analogous to a virtual machine the same way an apartment is analogous to a house. A house (and a VM) typically has plenty of space for a variety of activities, and does not really share much of anything with the neighbors in terms of utilities etc. An apartment (or a container) is much more dedicated to your present needs, and infrastructure is shared with neighbors. 

With a container, the purpose is to run ONE application. You install only those dependencies strictly necessary to run that application, and you do so on top of the smallest possible OS layer. All this is then packaged into an extremely light-weight image which holds these pieces plus your code. For example, the container that we ran is only ~300MB, and it includes all of these things PLUS its own OS. Let's explore this by telling the container to run a command other than the one that is specified by default:

```bash
docker run -p 8888:8888 bmcilw1/docker_intro bash
```

This will launch bash prompt for that container. Take a look around. You can leave by typing `exit` into the bash prompt.

OK, so that's all fine for one application. The true power of Docker is that it can actually handle running MANY containers simultaneously, on limited hardware. This is because spinning up a container, unlike starting a VM, is actually a very cheap process. You can try launching many versions of the container by running `docker run -d bmcilw1/docker_intro` and see them all with `docker ps`. When your done, kill them all (haha) with `docker kill the_id's_here`.

How did I set this up
---------------------

Setting up my application to run on Docker was actually far easier than trying to run it locally, as I did not have most of the dependencies installed. Dockerizing an application takes place in just a few steps. First, you need the code that you want to run. Then, you write a Dockerfile that specifies which container image you wish to use as your starting point, adds any dependencies not present, and finally adds your code to the container. Last, you build that image. At that point, you can then run that container as we have before.

You can view the complete code files here:

Build them yourself by cloning the repo and opening the folder running:

```bash
docker build -t my_docker_intro .
```

And run it using

```bash
docker run -d -p 8888:8888 my_docker_intro
```

Takeaways
---------

In this tutorial, we've explored Docker basics and shown how we can use Docker to run arbitrary code. The next time that your find yourself wanting to add something to a server, I hope you remember the power, portability, and cost-effectiveness of trying out Docker.

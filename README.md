An Intro to Docker
==================

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

Once you have Docker, if you have an x86-like machine (Windows/Mac/Linux) you can run the project by typing

```bash
docker run bmcilw1/mnist
```

Or, on a raspberry pi or other ARM processor device you will need to add `:rpi` to the end of the container name like below. Remember to do this each time the container name appears!

```bash
docker run bmcilw1/mnist:rpi

```

This will take a long time the first run because it needs to fetch the container from your internet connection.

What did NOT happen
-------------------

To begin to understand this, the first thing to realize is that running these commands did NOT actually install anything at all onto your computer. The only thing that was installed was Docker itself, which we did in step one. We just told Docker to run this thing, and it just worked. The only thing that was downloaded was something called a container, an image containing the code that we wanted to run.

What just happened?
-------------------

Docker ran an application contained in a container. That application did four things:

    1. Downloaded to the container many images of handwritten digits 0-9.
    2. Trained on several hundred of those images by being shown the image and told what number it is, 0-9.
    3. Tested on test images that it never saw before by being shown the image and guessing 
       which number it was, 0-9.
    4. Reported on the accuracy of the guesses by being told the correct answers and printing the 
       accuracy 0-1, 1 being perfect accuracy.

This is called the [MNIST](https://en.wikipedia.org/wiki/MNIST_database) problem, and is commonly known as the hello world program in machine learning.

So what is Docker?
---------------

Docker runs arbitrary code by running it in something called a container. I like the explanation found [here](https://blog.docker.com/2016/03/containers-are-not-vms/). A container is analogous to a virtual machine the same way an apartment is analogous to a house. A house (and a VM) typically have plenty of space for a variety of activities, and does not really share much of anything with the neighbors in terms of utilities etc. An apartment (or a container) are both much more dedicated to your present needs, and infrastructure is shared with neighbors. 

With a container, the purpose is to run ONE application. You install only those dependencies strictly necessary to run that application, and you do so on top of the smallest possible OS layer. All this is then packaged into an extremely light-weight image which holds these pieces plus your code. For example, the container that we ran is only ~300MB, and it includes all of these things PLUS its own OS. Let's explore this by telling the container to run a command other than the one that is specified by default:

```bash
docker run -it bmcilw1/mnist bash
```

This will launch bash prompt for that container. Take a look around. You can leave by typing `exit` into the bash prompt.

OK, so that's all fine for one application. The true power of Docker is that it can actually handle running MANY containers simultaneously, on limited hardware. This is because spinning up a container, unlike starting a VM, is actually a very cheap process. You can try launching many versions of the container by running `docker run -d bmcilw1/mnist` and see them all with `docker ps`. You might wonder why the containers exit after running the code. This is because each container launches for the purpose of running only one command, and will auto-exit upon the completion of that command.

How did I set this up
---------------------

Setting up my application to run on Docker was actually pretty easy. Dockerizing an application takes place in just a few steps. First, you need the code that you want to run. Then, you write a Dockerfile that specifies which container image you wish to use as your starting point, adds any dependencies not present, and finally adds your code to the container. Last, you build that image. At that point, you can then run that container as we have before.

You can view the complete code files here: https://github.com/bmcilw1/MNIST

Build them yourself by cloning the repo and opening the folder running:

```bash
docker build -t my_mnist .
```

And run it using

```bash
docker run my_mnist
```

Takeaways
---------

In this tutorial, we've explored Docker basics and shown how we can use Docker to run arbitrary code. The next time that your find yourself wanting to add something to a server, I hope you remember the power, portability, and cost-effectiveness of trying out Docker.

FROM tensorflow/tensorflow
# Docker containers are built on top of one another. I skipped installing the
# necessary dependencies required to run TensorFlow by building our container 
# on top of the default provided by TensorFlow.

MAINTAINER Brian McIlwain <brianwmcilwain@gmail.com>

# Add our code file
COPY mnist_softmax.py /root/mnist_softmax.py

# Specify the default command for this container - run our code
CMD ["/usr/bin/python", "/root/mnist_softmax.py"]

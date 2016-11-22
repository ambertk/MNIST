FROM tensorflow/tensorflow
MAINTAINER Brian McIlwain <brianwmcilwain@gmail.com>

ADD mnist_softmax.py /root/mnist_softmax.py

CMD ["/usr/bin/python", "/root/mnist_softmax.py"]

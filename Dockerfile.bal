FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y default-jdk
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
RUN apt-get update
RUN apt-get install -y gradle
COPY . /usr/src/myapp
RUN cd /usr/src/myapp/downloads && tar -xvf opencv-2.4.13.tar
RUN ls -alh
RUN cd /usr/src/myapp/downloads/opencv-2.4.13 && mkdir release
RUN cd /usr/src/myapp/downloads/opencv-2.4.13/release && cmake -DBUILD_SHARED_LIBS=OFF .. 
RUN cd /usr/src/myapp/downloads/opencv-2.4.13/release && make -j8
RUN cp /usr/src/myapp/downloads/opencv-2.4.13/release/lib/* /usr/src/myapp/libs/
RUN cp /usr/src/myapp/downloads/opencv-2.4.13/release/bin/*.jar /usr/src/myapp/libs/
RUN cd /usr/src/myapp && gradle clean && gradle jar
RUN ln -s /dev/null /dev/raw1394
WORKDIR /usr/src/myapp

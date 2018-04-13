FROM alpine:3.7
FROM openjdk:alpine

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN export PATH=$PATH:$JAVA_HOME/bin

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

RUN env

RUN javac Main.java

RUN ls -ltra

RUN java Main


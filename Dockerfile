FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get upgrade -y
RUN apt install gcc gdb make -y


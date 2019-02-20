FROM ubuntu:18.04

RUN apt update -y && apt clean all
RUN apt install -y cups
ADD adjust-config.sh /adjust-config.sh
ADD start-cups.sh /start-cups.sh
RUN chmod 755 /adjust-config.sh /start-cups.sh
RUN /adjust-config.sh
RUN apt install cups-pdf
RUN echo root:1234 | chpasswd

EXPOSE 631

CMD ["/start-cups.sh"]
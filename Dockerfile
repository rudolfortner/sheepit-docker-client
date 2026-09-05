FROM ubuntu:resolute

ENV DEBIAN_FRONTEND=noninteractive

# UPDATE BASE IMAGE
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

# INSTALL DEPENDENCIES
RUN apt-get install default-jre wget -y

# APT CLEANUP
RUN apt-get autoremove -y
RUN apt-get autoclean -y

# DOWNLOAD LATEST CLIENT
WORKDIR /sheepit
COPY get_sheepit.sh .
RUN ./get_sheepit.sh
RUN rm get_sheepit.sh

# DEFAULT ENV VARIABLES
ENV SHEEPIT_HOSTNAME="ortner-effects-docker-client"
ENV SHEEPIT_LOGIN="ortner-effects"
ENV SHEEPIT_PASSWORD="7D0qBQEhvjsjmtiJYuJ9FdKC4ieAtVKHhl1Xrz4N"
ENV SHEEPIT_UI="text"

# ADD START SCRIPT
COPY start_sheepit.sh .

# ENTRYPOINT
ENTRYPOINT ["./start_sheepit.sh"]

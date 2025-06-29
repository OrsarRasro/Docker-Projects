# Use Amazon Linux 2 as the base operating system
FROM amazonlinux:2

# Update system packages and install required software
# httpd = Apache web server, wget = download files, unzip = extract zip files
RUN yum update -y && \
    yum install -y httpd wget unzip && \
    yum clean all

# Set working directory to Apache's web root folder
WORKDIR /var/www/html

# Download portfolio from GitHub, extract it, copy files to web root, then cleanup
RUN wget https://github.com/OrsarRasro/emmanuel-portfolio/archive/refs/heads/master.zip && \
    unzip master.zip && \
    cp -r emmanuel-portfolio-master/* . && \
    rm -rf emmanuel-portfolio-master master.zip

# Tell Docker this container will use port 80 for web traffic
EXPOSE 80

# Start Apache web server in foreground mode when container runs
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
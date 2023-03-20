FROM mcr.microsoft.com/playwright:v1.31.0-focal

RUN apt-get update
RUN apt-get install sudo

RUN sudo su

RUN if ! [[ "18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]]; \
    then \
        echo "Ubuntu $(lsb_release -rs) is not currently supported."; \
    exit; \
    fi 

RUN sudo su
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN exit

RUN sudo apt-get update

RUN sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
# optional: for bcp and sqlcmd
RUN sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18

RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc

RUN sudo apt-get install -y unixodbc-dev

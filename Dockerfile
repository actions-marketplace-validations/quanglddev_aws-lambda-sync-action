FROM amazonlinux:2.0.20210813.1

USER root

RUN yum -y update

RUN yum install -y amazon-linux-extras
RUN amazon-linux-extras enable python3.8
RUN yum install -y python3.8

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y jq
RUN yum install -y zip

# RUN yum -y groupinstall "Development Tools"
# RUN yum -y install openssl-devel bzip2-devel libffi-devel

# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8

# RUN python3.8 --version
# RUN python -V

# RUN apt-get update
# RUN apt-get install -y jq zip
# RUN apt-get install -y python3-dev libpq-dev
RUN pip install awscli
RUN pip install virtualenv

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
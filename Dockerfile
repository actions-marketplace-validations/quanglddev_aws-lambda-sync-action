FROM amazonlinux:2.0.20210813.1

RUN yum install -y amazon-linux-extras

# RUN apt-get update
# RUN apt-get install -y jq zip
# RUN apt-get install -y python3-dev libpq-dev
# RUN pip install awscli
# RUN pip install virtualenv

# ADD entrypoint.sh /entrypoint.sh
# RUN chmod +x entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
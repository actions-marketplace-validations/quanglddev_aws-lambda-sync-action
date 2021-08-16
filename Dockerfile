FROM python:3.7

RUN apt-get update
RUN apt-get install -y jq zip
RUN pip install awscli
RUN pip install virtualenv

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
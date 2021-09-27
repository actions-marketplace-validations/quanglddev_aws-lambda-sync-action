FROM python:3.7

RUN apt-get update
RUN apt-get install -y jq zip
RUN apt-get install python3-dev libpq-dev
RUN pip install awscli
RUN pip install virtualenv

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
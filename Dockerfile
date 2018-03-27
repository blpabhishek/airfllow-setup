FROM puckel/docker-airflow:1.9.0

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

USER root

RUN apt-get update -y && apt-get install -y \
	wget \
	build-essential \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/man/man1 \
    && pip install boto3 \
    && pip install 'sqlalchemy>=1.1.15, <1.2.0' \
    && pip install psycopg2-binary

USER airflow

RUN pip install awscli --user

WORKDIR /usr/local/airflow

ENV PATH "$PATH:/usr/local/airflow/.local/bin"

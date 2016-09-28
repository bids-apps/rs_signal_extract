FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y wget
RUN wget -O /etc/apt/sources.list.d/neurodebian.sources.list http://neuro.debian.net/lists/xenial.us-ca.full
RUN apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

# Run apt-get calls
RUN apt-get update \
    && apt-get install -y python3-pip python3-matplotlib python3-scipy \
	python3-nibabel python3-sklearn

RUN pip3 install nilearn==0.2.6
RUN mkdir -p /code

COPY run.py /code/run.py
COPY main.py /code/main.py
WORKDIR /code
RUN python3 -c "import main; main.copy_atlas()"

COPY version /version

ENTRYPOINT ["/code/run.py"]

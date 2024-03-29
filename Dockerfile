FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -q --no-install-recommends wget gnupg2 && \
    wget --progress=dot:giga -O- http://neuro.debian.net/lists/jammy.us-ca.libre | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com 0xA5D32F012649A5A9 && \
    rm -rf /var/lib/apt/lists/*

# Run apt-get calls
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
                python3-pip \
                python3-matplotlib \
                python3-scipy \
	            python3-nibabel \
                python3-sklearn && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install nilearn==0.9.2 && \
    mkdir -p /code

COPY run.py /code/run.py
COPY main.py /code/main.py
WORKDIR /code
RUN python3 -c "import main; main.copy_atlas()"

COPY version /version

ENTRYPOINT ["/code/run.py"]

# Makefile that defines simple testing

all: test-python

get_data:
	if [ ! -d data/ds005-deriv-light/derivatives ]; then wget -c "https://googledrive.com/host/0B2JWN60ZLkgkMEw4bW5VUUpSdFU/ds005-deriv-light.tar" && mkdir -p data && tar xf ds005-deriv-light.tar -C data && rm ds005-deriv-light.tar; fi


test-python: get_data
	python3 test.py

build-docker: Dockerfile main.py run.py
	docker build -t bids/rs_signal_extract .

test-docker: get_data
	-mkdir -p docker_outputs
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 01
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 02
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 03
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs group

# Makefile that defines simple testing

all: test-python

get_data:
	if [ ! -d data/ds005-deriv-light/derivatives ]; then wget -c -O ds005-deriv-light.tar "https://files.osf.io/file?path=%2F57e549c2b83f6901d357d15f&provider=osfstorage&nid=9q7dv&accept_url=false&action=download" && mkdir -p data && tar xf ds005-deriv-light.tar -C data && rm ds005-deriv-light.tar; fi


test-python: get_data
	python3 test.py

build-docker: Dockerfile main.py run.py
	python -c "import main; main.copy_atlas()"
	docker build -t bids/rs_signal_extract .

run-interative:
	docker run -it --entrypoint /bin/bash -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract 

test-docker: get_data
	-mkdir -p docker_outputs
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 01
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 02
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs participant --participant_label 03
	docker run -v $(shell pwd)/data:/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-light /outputs group

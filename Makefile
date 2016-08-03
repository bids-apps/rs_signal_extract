# Makefile that defines simple testing

all: test-python

test-python:
	python3 test.py

build-docker: Dockerfile
	docker build -t bids/rs_signal_extract

test-docker:
	-mkdir docker_outputs
	docker run -v $(shell pwd):/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-3subjects /outputs participant --participant_label 01
	docker run -v $(shell pwd):/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-3subjects /outputs participant --participant_label 02
	docker run -v $(shell pwd):/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-3subjects /outputs participant --participant_label 03
	docker run -v $(shell pwd):/data -v $(shell pwd)/docker_outputs:/outputs bids/rs_signal_extract /data/ds005-deriv-3subjects /outputs group

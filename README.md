## The Resting-state signal estraction App

This is a BIDS-App to extract signal from a parcellation with nilearn,
typically useful in a context of resting-state data processing.

### Description

Nilearn is a Python tools for general multivariate manipulation of series
of neuroimaging volumes. It may be used for many purposes by writing
simple Python scripts, as described in the documentation
http://nilearn.github.io. The strength of nilearn are multivariate
statistics and predictive models, in partical with appications to
decoding or resting-state analysis.

Here, we use the nilearn NiftiLabelsMasker to extract time-series on a
parcellation, or "max-prob" atlas:
http://nilearn.github.io/connectivity/functional_connectomes.html#time-series-from-a-brain-parcellation-or-maxprob-atlas

### Documentation

The nilearn documentation can be found on:
http://nilearn.github.io

### How to report errors

If there are bugs or incomprehensible errors with nilearn, please report
them on the nilearn github issue page:
https://github.com/nilearn/nilearn/issues

Please ask questions on how to use nilearn, on neurostars, with the
nilearn tag:
http://neurostars.org/t/nilearn/


### Acknowledgements

If you use nilearn, please cite the corresponding paper: Abraham 2014,
Front. Neuroinform., Machine learning for neuroimaging with scikit-learn
http://dx.doi.org/10.3389/fninf.2014.00014

We acknowledge all the nilearn developers
(https://github.com/nilearn/nilearn/graphs/contributors)
as well as the BIDS-Apps team
https://github.com/orgs/BIDS-Apps/people


### Usage
This App has the following command line arguments:

```

  usage: run.py [-h]
                [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL ...]]
                bids_dir output_dir {participant,group}

  BIDS App entrypoint script to extract time-series from resting-state.

  positional arguments:
    bids_dir              The directory with the input dataset formatted
                          according to the BIDS standard.
    output_dir            The directory where the output files should be stored.
                          If you are running group level analysis this folder
                          should be prepopulated with the results of
                          theparticipant level analysis.
    {participant,group}   Level of the analysis that will be performed. Multiple
                          participant level analyses can be run independently
                          (in parallel) using the same output_dir.

  optional arguments:
    -h, --help            show this help message and exit
    --participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL ...]
                          The label(s) of the participant(s) that should be
                          analyzed. The label corresponds to
                          sub-<participant_label> from the BIDS spec (so it does
                          not include "sub-"). If this parameter is not provided
                          all subjects should be analyzed. Multiple participants
                          can be specified with a space separated list.

```


### Special considerations
None foreseen

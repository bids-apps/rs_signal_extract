
import os
from glob import glob

import numpy as np
from sklearn import covariance

from nilearn import input_data, datasets



def main(args):
    subjects_to_analyze = []
    # only for a subset of subjects
    if args.participant_label:
        subjects_to_analyze = args.participant_label
    # for all subjects
    else:
        subject_dirs = glob(os.path.join(args.bids_dir,
                            "derivatives",
                            "sub-*"))
        subjects_to_analyze = [subject_dir.split("-")[-1]
                               for subject_dir in subject_dirs]

    if args.analysis_level == "participant":
        participant_level(args, subjects_to_analyze)
    elif args.analysis_level == "group":
        group_level(args, subjects_to_analyze)


def participant_level(args, subjects_to_analyze):
    # The subject level analysis: extract time-series per subject
    # Retrieve the atlas
    atlas_data = datasets.fetch_atlas_basc_multiscale_2015()
    atlas_filename = atlas_data.scale122

    # find all RS scans and extract time-series on them
    for subject_label in subjects_to_analyze:
        for fmri_file in glob(os.path.join(args.bids_dir,
                                           "derivatives",
                                           "sub-%s" % subject_label,
                                           "func", "*_hmc_mni.nii.gz")
                          ):
            masker = input_data.NiftiLabelsMasker(
                            labels_img=atlas_filename,
                            standardize=True,
                            detrend=True,
                            verbose=3)
            time_series = masker.fit_transform(fmri_file)
            out_file = os.path.split(fmri_file)[-1].replace("_hmc_mni.nii.gz",
                            "_time_series.tsv")
            out_file = os.path.join(args.output_dir, out_file)
            np.savetxt(out_file, time_series, delimiter='\t')

            estimator = covariance.LedoitWolf(store_precision=True)
            estimator.fit(time_series)
            out_file = os.path.split(fmri_file)[-1].replace("_hmc_mni.nii.gz",
                            "_connectome.tsv")
            out_file = os.path.join(args.output_dir, out_file)
            np.savetxt(out_file, estimator.precision_, delimiter='\t')


def group_level(args, subjects_to_analyze):
    # running group level
    time_series = []
    for subject_label in subjects_to_analyze:
        for time_series_file in glob(os.path.join(args.output_dir,
                                     "sub-%s*_series.tsv" % subject_label)):
            time_series.append(np.loadtxt(time_series_file))
    time_series = np.concatenate(time_series)

    estimator = covariance.LedoitWolf(store_precision=True)
    estimator.fit(time_series)
    out_file = "group_connectome.tsv"
    out_file = os.path.join(args.output_dir, out_file)
    np.savetxt(out_file, estimator.precision_, delimiter='\t')


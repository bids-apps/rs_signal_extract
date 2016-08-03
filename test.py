"""
Simple code to smoke test the functionality.
"""

import argparse
import os

args = argparse.Namespace(participant_label=[],
                          analysis_level="participant",
                          bids_dir="./ds005-deriv-3subjects",
                          output_dir="./output")

if not os.path.exists(args.output_dir):
    os.makedirs(args.output_dir)

from main import main

# Smoke test the participant level
main(args)

# Smoke test the group level
args.analysis_level = "group"
main(args)


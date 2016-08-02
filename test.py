"""
Simple code to smoke test the functionality.
"""

import argparse
import os

args = argparse.Namespace(participant_label=[],
                          analysis_level="participant",
                          bids_dir="./ds005-deriv-3subjects",
                          output_dir="./output")

os.makedirs(args.output_dir)


from main import main
main(args)


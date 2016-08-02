"""
Simple code to smoke test the functionality.
"""

import argparse

args = argparse.Namespace(participant_label=[],
                          analysis_level="participant",
                          bids_dir="./ds005-deriv-3subjects",
                          output_dir="./output")


from main import main
main(args)


#!/usr/bin/env python3
"""
diff - Find the differences between two files asynchronously.

"""

__version__ = '0.0.1'
__author__ = 'diversemix'
__licence__ = 'MIT'

import time
import click
from diff.sequential_differ import SequentialDiffer


@click.command()
@click.argument('file1', nargs=1, type=str)
@click.argument('file2', nargs=1, type=str)
def main(file1: str, file2: str) -> object:
    start_time = time.time()
    x = SequentialDiffer.diff(file1, file2)
    elapsed = time.time() - start_time
    print(x)
    print("Time Elapsed: ", elapsed)


if __name__ == "__main__":
    main()

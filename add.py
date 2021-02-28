#!/usr/bin/env nix-shell
#! nix-shell -i python -p python

import sys, os
import os.path as path

def run():
    if (len(sys.argv) < 3):
        sys.exit('Arguments missing')

    files = sys.argv[1:-1]
    package = sys.argv[-1]
    stow_dir = os.getcwd()
    target = path.join(stow_dir, '..')

    # Move file into package, then restow package
    # First, need to calculate position of file relative to target
    # Then need to move the file to this path relative to package

    print 'files:', files
    print 'package:', package
    print 'stow_dir:', stow_dir
    print 'target:', target

    print '---'

    for f in files:
        relpath = path.relpath(f, target)
        stowpath = path.join(package, relpath)

        print 'mkdir -p', path.dirname(stowpath)
        print 'mv', f, stowpath
        print 'stow', package

if __name__ == "__main__":
    run()

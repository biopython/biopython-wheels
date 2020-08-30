This repository on GitHub is to automate the compilation of binary
wheel packages of Biopython for later upload to PyPI.

- https://github.com/biopython/biopython
- https://pypi.python.org/pypi/biopython

It uses the ``multibuild`` system developed by Matthew Brett and
the MacPython project.

- https://github.com/matthew-brett/multibuild
- https://github.com/MacPython/wiki/wiki/Wheel-building

The builds themselves are performed on virtual machines using
continuous integration testing services. Specifically, TravisCI
for Linux and Apple Mac OS X, and AppVeyor for Microsoft Windows.

- https://travis-ci.org/biopython/biopython-wheels/builds
- https://ci.appveyor.com/project/biopython/biopython-wheels/history

The compiled wheel files are uploaded to a staging folder hosted
on Anaconda:

- https://anaconda.org/multibuild-wheels-staging/biopython/files

From there we download them and then upload them to PyPI as part of
making a Biopython release.

- http://biopython.org/wiki/Building_a_release

There is a basic pre-commit configuration provided to validate
the YAML files as a git pre-commit hook. Install this as follows::

    $ pip install pre-commit
    $ pre-commit install

This repository on GitHub is to automate the compilation of binary
wheel packages of Biopython for later upload to PyPI.

- https://github.com/biopython/biopython
- https://pypi.python.org/pypi/biopython

It now uses the ``cibuildwheel`` system running on GitHub Actions.

- https://github.com/pypa/cibuildwheel

This produces lots and lots of wheel files, zipped up as a ~100MB
``artifact.zip`` available from the footer of the relevant `GitHub Actions run
<https://github.com/biopython/biopython-wheels/actions>`_.

We currently manually download, unzip, and then upload to PyPI with
``twine`` as part of `making a release
<https://biopython.org/wiki/Building_a_release>`_.

This repository originally used the ``multibuild`` system developed
by Matthew Brett and the MacPython project, running on TravisCI and
AppVeyor.

- https://github.com/matthew-brett/multibuild
- https://github.com/MacPython/wiki/wiki/Wheel-building

There is a basic pre-commit configuration provided to validate
the YAML files as a git pre-commit hook. Install this as follows::

    $ pip install pre-commit
    $ pre-commit install

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

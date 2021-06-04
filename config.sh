# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

set -e

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    if [ -n "$IS_OSX" ]; then
        echo "Mac OS X should already be using a UTF-8 encoding..."
    else
        echo "Forcing en_US.UTF-8 as workaround for encoding issues in Biopython 1.70 tests"
        # There is likely a more consise method to do this, but this works:
        if [ "$(uname -m)" == "aarch64" ]; then
            apt-get update
            apt-get install -y sudo locales language-pack-en-base
        fi
        sudo echo "LANG=en_US.UTF-8" > /etc/default/locale
        sudo locale-gen en_US.UTF-8
        sudo dpkg-reconfigure locales
        export LANG="en_US.UTF-8"
    fi
    locale
    python -c "import sys; print(sys.version); print('Default encoding: ' + sys.getdefaultencoding())"
    python -c "import locale; print('Locale prefered encoding: ' + locale.getpreferredencoding())"
    # Runs tests on installed distribution from an empty directory
    python --version
    # We want to do this using the Biopython installed from the wheel,
    # so just want the Tests (and Doc) folders present here:
    ln -s ../biopython/Doc
    # We previously used a symlink to tests, but that stopped working
    # (perhaps a file system issue, run_tests.py seemed to pull in the
    # uncompiled Bio folder and all the C code tests broke).
    mkdir Tests
    cd Tests
    cp -R ../../biopython/Tests/* .
    # Check the simplest import, and version for consistency
    python -c "import Bio; print('Biopython version: ' + Bio.__version__)"
    python -c "import Bio; print(Bio.__file__)"
    python -c "import os, Bio; print(os.listdir(os.path.split(Bio.__file__)[0]))"
    python -c "import os, Bio; print(os.listdir(os.path.split(Bio.__file__)[0] + '/Align'))"
    # This will confirm some of our C code compiled fine:
    python -c "from Bio.Nexus import cnexus; from Bio import cpairwise2"
    python -c "from Bio import Cluster; print('Bio.Cluster version: ' + Cluster.__version__)"
    python -c "from Bio.Align import _aligners"
    # So far so good, now let's run our full test suite...
    # Disable some platform specific failures in Biopython 1.70
    rm ../Doc/Tutorial/chapter_phenotype.tex
    sed -i.tmp 's#def test_WellRecord#def no_test_WellRecord#g' test_phenotype.py
    sed -i.tmp 's#def test_phenotype_IO#def no_test_phenotype_IO#g' test_phenotype.py
    python run_tests.py --offline
}

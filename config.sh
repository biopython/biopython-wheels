# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # To help with debug any unicode issues
    echo "Before trying to change locale..."
    locale
    python -c "import sys; print(sys.version); print('Default encoding: ' + sys.getdefaultencoding())"
    python -c "import locale; print('Locale prefered encoding: ' + locale.getpreferredencoding())"
    echo "Switching to LANG=en_US.utf8 etc"
    export LC_CTYPE="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export LANG="en_US.UTF-8"
    sudo dpkg-reconfigure locales
    locale
    python -c "import sys; print(sys.version); print('Default encoding: ' + sys.getdefaultencoding())"
    python -c "import locale; print('Locale prefered encoding: ' + locale.getpreferredencoding())"
    # Runs tests on installed distribution from an empty directory
    python --version
    # Debugging check for potential openssl issue in this Python
    python -c "import hashlib; print(sorted(x for x in dir(hashlib) if not x.startswith('_')))"
    # Check the simplest import, and version for consistency
    python -c "import Bio; print('Biopython version ' + Bio.__version__)"
    # This will confirm some of our C code compiled fine:
    python -c "from Bio.Nexus import cnexus; from Bio import cpairwise2"
    python -c "from Bio import Cluster; print('Bio.Cluster version ' + Cluster.version())"
    # So far so good, now let's run our full test suite...
    pwd
    if [ -n "$IS_OSX" ]; then
        cd ${TRAVIS_BUILD_DIR}/biopython/Tests
    else
        cd /io/biopython/Tests
    fi
    python run_tests.py --offline
    if [ -n "$IS_OSX" ]; then
	cd ${TRAVIS_BUILD_DIR}
    else
	cd /io/
    fi
    pwd
}

# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # To help with debug any unicode issues
    locale
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
    cd /io/biopython/Tests
    python run_tests.py --offline
    cd /io/tmp_for_test
    pwd
}

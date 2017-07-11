# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c "import Bio; print('Biopython version ' + Bio.__version__)"
    # This will confirm some of our C code compiled fine:
    python -c "from Bio.Nexus import cnexus; from Bio import cpairwise2"
    python -c "from Bio import Cluster; print('Bio.Cluster version ' + Cluster.version())"
    # TODO - Run our test suite...
}

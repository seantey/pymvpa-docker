# PyMVPA Docker container
Contains Dockerfile to build container for running PyMVPA code and other utility scripts.

For newly launched AWS EC2 instances, use the initialization script to automatically set up the Docker container and recommended directory structure for our specific usecase.

To fetch the fMRI data, either provide the data fetching script as an argument to the initialization script or manually copy the fMRI files into the `pymvpa-shared-folder/fmri-data` folder.



Useful docker commands:

File descriptions:
* `jupyter_launch_lab.sh` : Stops any existing jupyter server on port 8888 and launches a new server with configurations.
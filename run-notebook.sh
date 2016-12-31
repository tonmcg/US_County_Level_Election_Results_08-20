#head to http://localhost:8888 after running this (must have Docker installed locally btw)
#only a good idea to run this locally...
#Details on the notebook used can be found at: https://github.com/slarson/docker-stacks/blob/master/scipy-notebook/README.md
docker run -d -p 8888:8888 --user root -e GRANT_SUDO=yes -v `pwd`:/home/jovyan/work --name scipy-notebook slarson/scipy-notebook
echo "Point your browser at http://localhost:8888/notebooks/US_County_Level_Presidential_Results_12-16.ipynb

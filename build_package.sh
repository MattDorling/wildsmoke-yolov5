#!/bin/bash

conda activate yolov5

# prepare a package for this job
rm -r /home/s1802289/package
mkdir /home/s1802289/package
cd /home/s1802289/package
echo Created folder /home/s1802289/package

# clone necessary repos
echo "Cloning dataset"
git clone https://github.com/MattDorling/wildfire-dataset
echo "Cloning Yolov5"
git clone https://github.com/ultralytics/yolov5

# prepare data folders and populate them
echo "Preparing data"
mkdir data
mkdir data/images
mkdir data/labels
mv wildfire-dataset/aiformankind-v2/images/* data/images/
mv wildfire-dataset/aiformankind-v2/labels/* data/labels/
mv wildfire-dataset/open-climate-tech-2019a/images/* data/images/
mv wildfire-dataset/open-climate-tech-2019a/labels/* data/labels/

# get python script to split into train/valid data, run it
wget https://raw.githubusercontent.com/MattDorling/wildsmoke-yolov5/main/split-data.py
python split-data.py

# get config files and weights
echo "Fetching config files and weights"
wget https://raw.githubusercontent.com/MattDorling/wildsmoke-yolov5/main/data.yaml
wget https://raw.githubusercontent.com/MattDorling/wildsmoke-yolov5/main/yolov5m.yaml
wget https://github.com/ultralytics/yolov5/releases/download/v6.0/yolov5m6.pt


# create a .tar.gz ready for copying over to scratch
cd /home/s1802289
tar -cvzf package.tar.gz /home/s1802289/package

#!/bin/bash
#SBATCH --nodelist=landonia15
#SBATCH --job-name=md-smokedetect
#SBATCH --time=8:00:00
#SBATCH --mem=12000
#SBATCH --gres=gpu:4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=s1802289@ed.ac.uk

n_gpus=4
batch_size=32
start_time=$(date +%s)


eval "$(conda shell.bash hook)"
conda activate yolov5
nvidia-smi

echo "Begin copying package.tar.gz to scratch"
zip -r wildfire_package_${start_time}.zip package
mkdir /disk/scratch/s1802289
cp /home/s1802289/wildfire_package_${start_time}.zip /disk/scratch/s1802289/wildfire_package_${start_time}.zip
cd /disk/scratch/s1802289
echo "Extracting package in scratch"
unzip wildfire_package_${start_time}.zip
#cd /disk/scratch/s1802289/wildfire_package_${start_time}
cd /disk/scratch/s1802289/package
python -m torch.distributed.launch --nproc_per_node ${n_gpus} yolov5/train.py --img 640 --batch-size ${batch_size} --epochs 50 --data data.yaml --cfg yolov5l.yaml --weights yolov5l6.pt --name wildsmoke_${start_time}

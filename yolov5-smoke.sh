#!/bin/bash
#SBATCH --nodelist=landonia20
#SBATCH --job-name=md-smokedetect
#SBATCH --time=8:00:00
#SBATCH --mem=12000
#SBATCH --gres=gpu:4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=s1802289@ed.ac.uk

n_gpus=4
batch_size=16
start_time=$(date +%s)


conda activate yolov5
nvidia-smi

echo "Begin copying package.tar.gz to scratch"
rsync -av --progress /home/s1802289/package.tar.gz /disk/scratch/s1802289/wildfire_package_${start_time}.tar.gz
cd /disk/scratch/s1802289
echo "Extracting package in scratch"
tar -xvzf wildfire_package_${start_time}.tar.gz wildfire_package_${start_time}
python -m torch.distributed.launch --nproc_per_node ${n_gpus} yolov5/train.py --img 640 --batch-size ${batch_size} --epochs 50 --data data.yaml --cfg yolov5m.yaml --weights yolov5m.pt --name wildsmoke_${start_time}

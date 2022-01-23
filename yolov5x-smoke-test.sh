#!/bin/bash
#SBATCH --nodelist=landonia20
#SBATCH --job-name=md-smokedetect1
#SBATCH --time=8:00:00
#SBATCH --mem=12000
#SBATCH --gres=gpu:4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=s1802289@ed.ac.uk

n_gpus=4
batch_size=16

conda activate yolov5
nvidia-smi
cd /disk/scratch/s1802289/package
python -m torch.distributed.launch --nproc_per_node ${n_gpus} yolov5/train.py --img 640 --batch-size ${batch_size} --epochs 50 --data data.yaml --cfg yolov5x.yaml --weights yolov5x.pt --name wildsmoke_yolov5x_50ep

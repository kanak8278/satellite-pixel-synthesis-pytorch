#!/bin/bash
$TRAIN_PATH = "levir_dataset/train.csv"
$TEST_PATH = "levir_dataset/test.csv"
$OUTPUT_DIR = "."
$BASE_DIR = "levir_dataset"

pip install tensorboard
cd ~/satellite-pixel-synthesis-pytorch/
echo "Run train_3dis.py"


python -c "import torch; print(torch.cuda.device_count())"

python train_3dis.py --path levir_dataset/train.csv --test_path levir_dataset/test.csv --output_dir . --base_dir levir_dataset

# python -m torch.distributed.launch --nproc_per_node=8 --master_port=1234  train_3dis_attpatch.py --path texas/texas_train.csv --test_path texas/texas_test.csv --output_dir output_dir/
# python -m torch.distributed.launch --nproc_per_node=8 --master_port=1234 train_3dis_attpatch.py --path TRAIN_PATH --test_path TEST_PATH --output_dir OUTPUT_DIR
# python -m torch.distributed.launch --nproc_per_node=8 --master_port=1234 train_3dis.py --path=$TRAIN_PATH --test_path=$TEST_PATH --output_dir=$OUTPUT_DIR

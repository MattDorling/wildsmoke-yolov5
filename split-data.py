from sklearn.model_selection import train_test_split
import os
import shutil

data = os.listdir('data/images')
train, test = train_test_split(data, train_size=0.75, random_state=1)

for fn in train:
    label_fn = str(fn).split('.')[0] + '.txt'
    shutil.move(f'data/images/{fn}', f'data/images/train/{fn}')
    shutil.move(
        f'data/labels/{label_fn}', f'data/labels/train/{label_fn}')
for fn in test:
    label_fn = str(fn).split('.')[0] + '.txt'
    shutil.move(f'data/images/{fn}', f'data/images/valid/{fn}')
    shutil.move(
        f'data/labels/{label_fn}', f'data/labels/valid/{label_fn}')

from sklearn.model_selection import train_test_split
import os
import shutil

data = os.listdir('data/2019a-smoke-full')
train, test = train_test_split(data, train_size=0.75, random_state=1)

for fn in train:
    label_fn = str(fn).split('.')[0] + '.txt'
    shutil.copyfile(f'data/2019a-smoke-full/{fn}', f'data/images/train/{fn}')
    shutil.copyfile(
        f'data/2019a-smoke-full-labels/{label_fn}', f'data/labels/train/{label_fn}')
for fn in test:
    label_fn = str(fn).split('.')[0] + '.txt'
    shutil.copyfile(f'data/2019a-smoke-full/{fn}', f'data/images/valid/{fn}')
    shutil.copyfile(
        f'data/2019a-smoke-full-labels/{label_fn}', f'data/labels/valid/{label_fn}')

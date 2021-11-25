import pandas as pd
from pathlib import Path
from PIL import Image
import csv

setpath = Path('data/2019a-smoke-full')
csv_annotations = pd.read_csv('data/2019a-smoke-full.csv', index_col=False)
print(csv_annotations.head(5))
with open(f'{setpath}.csv', 'rt') as file:
    csv_rows = csv.reader(file)
    for row in csv_rows:
        minX, minY, maxX, maxY, filename = float(row[0]), float(row[1]), float(
            row[2]), float(row[3]), row[4]
        img = Image.open(f'{setpath}/{filename}')
        w, h = img.size
        filename = filename.split('.')[0]
        print(filename)
        class_index = 0
        bbox_x_center = ((minX + maxX))/2 / w
        bbox_y_center = ((minY + maxY))/2 / h
        bbox_width = (maxX - minX) / w
        bbox_height = (maxY - minY) / h
        with open(f'{setpath.parent}/labels/{filename}.txt', 'w') as newfile:
            newfile.write(
                f'{class_index} {bbox_x_center} {bbox_y_center} {bbox_width} {bbox_height}')

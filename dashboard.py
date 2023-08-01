import gradio as gr
import pandas as pd
from PIL import Image
import os
from tqdm import tqdm

# Load dataframes
train_df = pd.read_csv('cls/train_inference.csv')
test_df = pd.read_csv('cls/test_inference.csv')

base_dir = "/home/kanakraj/workspace/superresolution/datasets/levir_dataset/"
inference_imgs = "cls/inference_imgs/"


def create_inference_df(dataframe, inference_dir):
    a = dataframe['A']
    b = dataframe['B']
    print("Hello World!")
    pred_a = []
    pred_b = []

    for pth in tqdm(a):
        file = os.path.join(inference_dir, 'A', os.path.basename(pth))
        if not os.path.exists(file):
            print("=")
            continue
        pred_a.append(file)
    for pth in tqdm(b):
        file = os.path.join(inference_dir, 'B', os.path.basename(pth))
        if not os.path.exists(file):
            print("=")
            continue
        pred_b.append(file)

    dataframe['pred_A'] = pred_a
    dataframe['pred_B'] = pred_b

    print(dataframe.head())
    return dataframe


# df = pd.read_csv("/home/kanakraj/workspace/superresolution/datasets/levir_dataset/test.csv")
# create_inference_df(df, inference_imgs).to_csv("cls/test_inference.csv", index=False)
# exit()


# Define function to display images
def display_images(index, dataframe, flip):
    if dataframe == 'Train':
        df = train_df
    else:
        df = test_df
    row = df.iloc[index]
    if flip:
        image1_path = os.path.join(base_dir, row['B'])
        image2_path = os.path.join(base_dir, row['down_A'])
        image3_path = os.path.join(".", row['pred_A'])
        image4_path = os.path.join(base_dir, row['A'])
    else:
        image1_path = os.path.join(base_dir, row['A'])
        image2_path = os.path.join(base_dir, row['down_B'])
        image3_path = os.path.join(".", row['pred_B'])
        image4_path = os.path.join(base_dir, row['B'])
    image1 = Image.open(image1_path)
    image2 = Image.open(image2_path)
    image3 = Image.open(image3_path)
    image4 = Image.open(image4_path)
    label1 = os.path.basename(image1_path)
    label2 = os.path.basename(image2_path)
    label3 = os.path.basename(image3_path)
    label4 = os.path.basename(image4_path)
    return [label1, image1, label2, image2, label3, image3, label4, image4]


gr.Interface(
    fn=display_images,
    inputs=[
        gr.inputs.Slider(minimum=0, maximum=len(train_df) - 1, step=1, default=0),
        gr.inputs.Radio(['Train', 'Test'], label='Dataframe'),
        gr.inputs.Checkbox(label='Flip')
    ],
    outputs=[
        gr.outputs.Textbox(label='Label 1'),
        gr.outputs.Image(type='pil'),
        gr.outputs.Textbox(label='Label 2'),
        gr.outputs.Image(type='pil'),
        gr.outputs.Textbox(label='Label 3'),
        gr.outputs.Image(type='pil'),
        gr.outputs.Textbox(label='Label 4'),
        gr.outputs.Image(type='pil')
    ],
).launch()

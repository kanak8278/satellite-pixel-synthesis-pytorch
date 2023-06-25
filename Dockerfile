FROM pytorch/pytorch:latest

# Install system libraries required by OpenCV.
RUN apt-get update
COPY ./model home/satellite-pixel-synthesis-pytorch/model
COPY ./op home/satellite-pixel-synthesis-pytorch/op
COPY ./requirements.txt home/satellite-pixel-synthesis-pytorch/
COPY ./*.py home/satellite-pixel-synthesis-pytorch/
# Install Libraries from PyPI.
RUN echo python --version
RUN cd home/satellite-pixel-synthesis-pytorch
RUN echo ls -l
RUN #pip install -r requirements.txt


FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Install system libraries required by OpenCV.
RUN apt-get update
COPY ./model home/satellite-pixel-synthesis-pytorch/model
COPY ./op home/satellite-pixel-synthesis-pytorch/op
COPY ./requirements.txt home/satellite-pixel-synthesis-pytorch/
COPY ./*.py home/satellite-pixel-synthesis-pytorch/
COPY ./environment.yml home/satellite-pixel-synthesis-pytorch/
# Install Libraries from PyPI.
RUN python --version
WORKDIR /workspace/home/satellite-pixel-synthesis-pytorch
RUN pwd
#RUN pip install -r ./requirements.txt
#RUN pip install ninja
RUN conda env create -f environment.yml
RUN apt-get --yes install g++
RUN conda init
# CMD ["cd /workspace/home/satellite-pixel-synthesis-pytorch && conda activate spsp && python test.py"]
RUN /bin/bash

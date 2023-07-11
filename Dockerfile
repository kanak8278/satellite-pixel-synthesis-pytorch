FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Install system libraries required by OpenCV.
RUN apt-get update
COPY ./model home/satellite-pixel-synthesis-pytorch/model
COPY ./op home/satellite-pixel-synthesis-pytorch/op
COPY ./requirements.txt home/satellite-pixel-synthesis-pytorch/
COPY ./*.py home/satellite-pixel-synthesis-pytorch/
COPY ./environment.yml home/satellite-pixel-synthesis-pytorch/
# Install Libraries from PyPI.
WORKDIR /workspace/home/satellite-pixel-synthesis-pytorch

RUN pip3 install -r requirements.txt
COPY ./run_script.sh .
RUN chmod +x run_script.sh
#SHELL ["home/satellite-pixel-synthesis-pytorch/run_script.sh"]
#CMD ["python3", "test.py"]
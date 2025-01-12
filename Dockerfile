FROM jupyter/pyspark-notebook:x86_64-ubuntu-22.04
LABEL maintainer="Colton Willig <coltonwillig@gmail.com>"

ARG HOME_DIR=/home/jovyan
ENV PYTHONPATH "$PYTHONPATH:$HOME_DIR"

USER jovyan

COPY ./requirements.txt $HOME_DIR/requirements.txt
RUN pip install --upgrade pip==24.3.1
RUN pip install --no-cache-dir -r $HOME_DIR/requirements.txt

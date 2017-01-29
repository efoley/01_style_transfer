FROM gcr.io/tensorflow/tensorflow:0.11.0-devel-gpu

RUN apt install git

# see http://stackoverflow.com/questions/32792469/insecureplatformwarning-when-building-docker-image
# about annoying warning messages that can appear here 
#RUN pip install --upgrade requests[security] ndg-httpsclient pyasn1
RUN pip install pillow

## NOTE that alternative way to do this is to base on Ubuntu image and do the following
## download & install Miniconda
#RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
#RUN bash Miniconda2-latest-Linux-x86_64.sh
#RUN conda update conda
#
#RUN conda create -n style-transfer python=2.7.9
#RUN source activate style-transfer
#RUN conda install -c conda-forge tensorflow=0.11.0
#RUN conda install scipy pillow

RUN git clone https://github.com/lengstrom/fast-style-transfer

WORKDIR fast-style-transfer

RUN curl -fSsl -O https://d17h27t6h515a5.cloudfront.net/topher/2017/January/587d1865_rain-princess/rain-princess.ckpt

RUN ["/bin/bash"]

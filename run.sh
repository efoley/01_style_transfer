#!/bin/bash

HOST_DATADIR=`pwd`/dockerdata

mkdir -p $HOST_DATADIR

pushd $HOST_DATADIR
curl -fSsl -o statue.jpg    http://traveldigg.com/wp-content/uploads/2016/05/Statue-of-Liberty-Pictures.jpg
curl -fSsl -o veggies.jpg   http://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/articles/health_tools/12_powerhouse_vegetables_slideshow/intro_cream_of_crop.jpg
popd

docker build -t 01_style_transfer .

CNAME="$(nvidia-docker run -it -d -v $HOST_DATADIR:/data 01_style_transfer)"

echo "CNAME=$CNAME"

docker exec $CNAME \
  python evaluate.py --checkpoint ./rain-princess.ckpt \
    --in-path /data/statue.jpg \
    --out-path /data/statue-stylized.jpg

docker exec $CNAME \
  python evaluate.py --checkpoint ./rain-princess.ckpt \
    --in-path /data/veggies.jpg \
    --out-path /data/veggies-stylized.jpg

docker stop $CNAME

#nvidia-docker run -v $HOST_DATADIR:/data 01_style_transfer \
#  python evaluate.py --checkpoint ./rain-princess.ckpt \
#    --in-path /data/statue.jpg \
#    --out-path /data/statue-stylized.jpg;\

eog $HOST_DATADIR/statue.jpg &
eog $HOST_DATADIR/statue-stylized.jpg
eog $HOST_DATADIR/veggies.jpg &
eog $HOST_DATADIR/veggies-stylized.jpg

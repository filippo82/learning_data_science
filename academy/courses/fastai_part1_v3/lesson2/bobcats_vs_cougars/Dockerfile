FROM python:3.7

RUN apt-get update && apt-get install -y python3-dev gcc
#libc-dev

# Install pytorch and fastai
#RUN pip3 install torch_nightly -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html
RUN pip3 install fastai "pillow<7"

# Install starlette and uvicorn
RUN pip3 install starlette uvicorn python-multipart aiohttp

ADD export.pkl export.pkl
#ADD usa-inaturalist-cats.pth usa-inaturalist-cats.pth
ADD cougar.py cougar.py

# Run it once to trigger resnet download
RUN python cougar.py

EXPOSE 8008

# Start the server
CMD ["python", "cougar.py", "serve"]

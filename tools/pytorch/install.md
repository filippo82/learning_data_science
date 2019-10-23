

conda create -n fastai python=3.7
conda activate fastai
conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
conda install matplotlib numpy jupyter requests

python -m ipykernel install --user --name fastai --display-name "Python (fastai)"

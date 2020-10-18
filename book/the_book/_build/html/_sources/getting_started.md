# Getting started

## Installation

```
python3 -m pip install --upgrade pip
pip3 install virtualenv virtualenvwrapper
```

Add these three lines to `$HOME/.zshrc`:
```
export WORKON_HOME=$HOME/Work/virtualenvs
# export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```
Close the terminal and open a new one.

## Create a virtual environment

```{code-block} shell
mkvirtualenv learning
workon learning
```

## Install Jupyter Book

```{code-block} shell
pip install -U jupyter-book cookiecutter
```
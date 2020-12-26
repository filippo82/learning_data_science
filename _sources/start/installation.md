# Getting started

## Installation

```shell
python3 -m pip install --upgrade pip
pip3 install virtualenv virtualenvwrapper
```

Add these three lines to `$HOME/.zshrc`:

```shell
export WORKON_HOME=$HOME/Work/virtualenvs
# export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```

Close the terminal and open a new one.

### Install Jekyll

Follow the instructions [here](https://jekyllrb.com/docs/installation/macos/).

```{code-block} shell
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
gem install --user-install bundler jekyll
ruby -v
echo 'export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"' >> ~/.zshrc
gem env
```

## Create a virtual environment (1)

```{code-block} shell
mkvirtualenv learning
workon learning
```

## Create a virtual environment (2)

```{code-block} shell
python -m venv ~/Work/venvs/lds
source ~/Work/venvs/lds/bin/activate
~/Work/venvs/lds/bin/python3.7 -m pip install --upgrade pip
```

Create an alias for the command above.

## Install packages

```{code-block} shell
pip install -r requirements.txt
```

## Create a new Jupyter Book template

```{code-block} shell
jb build new_book
```

## Configure the the book

TBD

## Compile the book

```{code-block} shell
jb build new_book
```

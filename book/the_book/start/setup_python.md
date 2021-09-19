# Setup Python

## Python

* [The right and wrong way to set Python 3 as default on a Mac](https://opensource.com/article/19/5/python-3-default-mac) from opensource.com
* [Managing Multiple Python Versions With pyenv](https://realpython.com/intro-to-pyenv/) from Real Python

List the available Python versions:

```{code-block} shell
pyenv install --list | grep " 3\.[678]"
```

Install a specific version:

```{code-block} shell
pyenv install -v 3.7.10"
```

Set the newly installed Python version as your global default:

```{code-block} shell
pyenv global 3.7.10"
pyenv versions
```

Add an additional configuration to your `.zshrc` file:

```{code-block} shell
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
```

Finally, add this line at the end of your `.zshrc`:
```{code-block} shell
export PATH="$(pyenv root)/shims:$PATH"
```

## Poetry

[Poetry](https://python-poetry.org/)

* [Package Python Projects the Proper Way with Poetry](https://hackersandslackers.com/python-poetry-package-manager/)
* [How to manage Python projects with Poetry](https://www.infoworld.com/article/3527850/how-to-manage-python-projects-with-poetry.html)

## Install `requirements.txt`

TBD

## JupyterLab

### Code Formatter

Follow [these instructions](https://jupyterlab-code-formatter.readthedocs.io/en/latest/how-to-use.html#chaining-default-formatters-one-after-the-other)
to change the default formatter:

go to “Settings” > “Advanced Settings Editor” > “Jupyterlab Code Formatter”, then in the “User Preferences” panel, enter, for example:

```{code-block} json
{
    "preferences": {
        "default_formatter": {
            "python": ["isort", "black"],
        }
    }
}
```

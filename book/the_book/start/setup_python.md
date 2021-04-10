# Setup Python

## Python

[The right and wrong way to set Python 3 as default on a Mac](https://opensource.com/article/19/5/python-3-default-mac)

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


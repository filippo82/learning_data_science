# Installation

## Common packages

### Homebrew

If you do not already have Homebrew installed on macOS, install it with the following command.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## AWS

### AWS CLI Version 2
Offical AWS [documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html#cliv2-mac-install-cmd).

```{code-block} shell
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

Check that the CLI has been correctly installed:
```shell
aws --version
```
which should output something like this:
```shell
aws-cli/2.0.57 Python/3.7.4 Darwin/19.6.0 exe/x86_64
```

### eksctl

Install the Weaveworks Homebrew tap:
```shell
brew tap weaveworks/tap
```

Install eksctl with the following command:
```shell
brew install weaveworks/tap/eksctl
```
If eksctl is already installed, run the following command to upgrade:
```shell
brew upgrade eksctl && brew link --overwrite eksctl
```

Test that your installation was successful with the following command.
```shell
eksctl version
```

### kubectl

If you used the preceding Homebrew instructions to install `eksctl` on macOS,
then `kubectl` has already been installed on your system.

I already have `kubectl` version `1.18`. Let's if it works.

Verify `kubectl` version with the following command:
```shell
kubectl version --short --client
```

### Install Helm

```shell
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

### Install fluxctl
```shell
brew install fluxctl
```
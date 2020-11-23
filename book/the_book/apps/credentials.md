# Credentials

## Configure AWS CLI credentials

```bash
aws configure --profile thebook
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: jrbhjsabfhjsbfkj;fhjkasdfhlajkshfjasdkhf
Default region name [None]: eu-central-1
Default output format [None]: json
```

```bash
export AWS_DEFAULT_REGION=eu-central-1
export AWS_PROFILE=thebook
export AWS_ACCOUNT_ID=$(aws --profile ${AWS_PROFILE} sts get-caller-identity | python -c 'import json,sys;obj=json.load(sys.stdin);print(obj["Account"])')
# export AWS_ACCOUNT_ID=533283293550
```

[Here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods)
you can see how to set and view configuration settings:
```
aws configure set region $AWS_REGION --profile swung
```

The region names and codes can be found [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints).

More information on the configuration of the AWS CLI can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

## Amazon EC2 key pair
Create a key pair for Amazon EC2
```{{code-block}} shell
aws ec2 create-key-pair --key-name KeyPair_ec2_gitops --query 'KeyMaterial' --output text > ~/.ssh/KeyPair_ec2_gitops.pem
chmod 400 ~/.ssh/KeyPair_ec2_gitops.pem
```
[Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html).

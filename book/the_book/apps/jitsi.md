# Jitsi

## Resources

## AWS

* [Self-Hosting Guide](https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-start)
* [Getting started with Jitsi, an open source web conferencing solution](https://aws.amazon.com/blogs/opensource/getting-started-with-jitsi-an-open-source-web-conferencing-solution/#deploying-jitsi-on-aws-ecs)
* [How to Setup Jitsi Meet on Azure/AWS/GCP](https://cloudinfrastructureservices.co.uk/how-to-setup-jitsi-meet-on-azure-aws-gcp/)
* [Hermes Writings](https://www.hermeswritings.com/self-hosted-jitsi-server-with-authentication-on-aws/)
* [Video 1](https://www.youtube.com/watch?v=s3noHzzSDN8)
* [Video 2](https://www.youtube.com/watch?v=QZCX2gBln1s)
* [Video 3](https://www.youtube.com/watch?time_continue=1&v=Jj8a6ZRgehI&feature=emb_title)
* [Hosting Jitsi Meet on AWS](https://jphblog.com/2020/04/jitsi-on-aws/)
* [From Zero to Jitsi Meet in 30 Minutes](https://brainfood.xyz/post/20200323-jitsi/)
* [How to Install Jitsi Meet Video Conferencing Solution on Debian 10](https://www.howtoforge.com/how-to-install-jitsi-meet-video-conferencing-solution-on-debian-10/)
* [Set up a Video Conferencing server for free with Jitsi-meet](https://medium.com/@jerome.dechauveron/how-to-set-up-video-conferencing-with-jitsi-meet-9fa704e4f66f)
* [hpi-schul-cloud/jitsi-deployment](https://github.com/hpi-schul-cloud/jitsi-deployment)

### Terraform

* [mavenik/jitsi-terraform](https://github.com/mavenik/jitsi-terraform/tree/master/aws)
* [Infrastructure as Code: Deploy Jitsi Meet to AWS](https://avasdream.engineer/terraform-jitsi)
* [Code for ^^^](https://github.com/AvasDream/terraform_aws_jitsi_meet)
* [Jitsi on AWS (with Terraform)](https://napo.io/posts/jitsi-on-aws-with-terraform/)

### GCP

* [Install Jitsi Meet on Compute Engine (GCP)](https://jochen.kirstaetter.name/install-jitsi-meet-on-gcp/)

### Azure
* [Host Private Video Meetings in Azure with Jitsi](https://build5nines.com/host-private-video-meetings-in-azure-with-jitsi/)

### Various
* [](https://github.com/spantaleev/matrix-docker-ansible-deploy)
* [Getting started with Jitsi, an open source web conferencing solution](https://aws.amazon.com/blogs/opensource/getting-started-with-jitsi-an-open-source-web-conferencing-solution/)
* [https://jphblog.com/2020/04/jitsi-on-aws/](https://jphblog.com/2020/04/jitsi-on-aws/)
* [Deploy Jitsi Meet using Docker](https://www.scaleway.com/en/docs/deploy-jitsi-meet-with-docker/)
* [A Jitsi Meet Chart for Kubernetes](https://github.com/taktakpeops/jitsi-meet-helm)
* [Host a Jitsi Meet Server](https://nerdonthestreet.com/wiki?find=Host+a+Jitsi+Meet+Server)

## Install on AWS

### Create a DNS record in Route53

Create an `A` DNS record.

### Create Security Group

Inbound:
*

Outbound:
* All traffic

### Create Launch Template


### Launch instance from template


### Associate Elastic IP to instance


### Connect to instance

```bash
$ ssh -i "KeyPair_ec2_swung.pem" ubuntu@jitsi.amstelhack2020.site
```

### Set up instance and install Jitsi

```bash
$ sudo apt update
$ sudo apt install apt-transport-https
$ sudo apt-add-repository universe
$ sudo apt update
$ sudo hostnamectl set-hostname jitsi
```

Modify `/etc/hosts` to add this line after `127.0.0.1 localhost`:
```bash
# 18.158.83.156 jitsi.amstelhack2020.site meet
127.0.1.1 jitsi.softwareunderground.site jitsi
```

```bash
dnsdomainname -f
```

```bash
$ curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'
$ echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null
$ sudo apt update
```

```bash
$ sudo ufw allow 80/tcp
$ sudo ufw allow 443/tcp
$ sudo ufw allow 4443/tcp
$ sudo ufw allow 10000/udp
$ sudo ufw allow 22/tcp
$ sudo ufw enable
$ sudo ufw status verbose
```

```bash
sudo apt install jitsi-meet
```

When the `jitsi-videobridge2` windows appears,
insert the hostname of the current installation: `jitsi.softwareunderground.org`

```bash
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
```

### Reconfigure

```bash
sudo dpkg-reconfigure jitsi-videobridge2
```

### Uninstall

```bash
sudo apt purge jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-prosody jitsi-meet-turnserver jitsi-meet-web jicofo jitsi-videobridge2
```

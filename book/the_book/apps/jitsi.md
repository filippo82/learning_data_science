# Jitsi

# Resources

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

## Terraform
* [mavenik/jitsi-terraform](https://github.com/mavenik/jitsi-terraform/tree/master/aws)
* [Infrastructure as Code: Deploy Jitsi Meet to AWS](https://avasdream.engineer/terraform-jitsi)
* [Code for ^^^](https://github.com/AvasDream/terraform_aws_jitsi_meet)
* [Jitsi on AWS (with Terraform)](https://napo.io/posts/jitsi-on-aws-with-terraform/)
*

## GCP
* [Install Jitsi Meet on Compute Engine (GCP)](https://jochen.kirstaetter.name/install-jitsi-meet-on-gcp/)

## Azure
* [Host Private Video Meetings in Azure with Jitsi](https://build5nines.com/host-private-video-meetings-in-azure-with-jitsi/)

## Various
* [](https://github.com/spantaleev/matrix-docker-ansible-deploy)
* [Getting started with Jitsi, an open source web conferencing solution](https://aws.amazon.com/blogs/opensource/getting-started-with-jitsi-an-open-source-web-conferencing-solution/)
* [https://jphblog.com/2020/04/jitsi-on-aws/](https://jphblog.com/2020/04/jitsi-on-aws/)
* [Deploy Jitsi Meet using Docker](https://www.scaleway.com/en/docs/deploy-jitsi-meet-with-docker/)
* [A Jitsi Meet Chart for Kubernetes](https://github.com/taktakpeops/jitsi-meet-helm)
* [Host a Jitsi Meet Server](https://nerdonthestreet.com/wiki?find=Host+a+Jitsi+Meet+Server)

# Install on AWS

## Create a DNS record in Route53

Create an `A` DNS record.

## Create Security Group

Inbound:
*

Outbound:
* All traffic

## Create Launch Template


## Launch instance from template


## Associate Elastic IP to instance


## Connect to instance

```bash
$ ssh -i "KeyPair_ec2_jitsi.pem" ubuntu@jitsi.softwareunderground.org
```

## Set up instance and install Jitsi

```bash
$ sudo apt update
$ sudo apt install apt-transport-https
$ sudo apt-add-repository universe
$ sudo apt update
$ sudo hostnamectl set-hostname meet
```

Modify `/etc/hosts` to add this line after `127.0.0.1 localhost`:
```bash
# 18.158.83.156 jitsi.amstelhack2020.site meet
18.158.83.156 jitsi.softwareunderground.org jitsi
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
$ sudo apt install jitsi-meet
```
When the `jitsi-videobridge2` windows appears,
insert the hostname of the current installation: `jitsi.softwareunderground.org`

```bash
$ sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
```

## Reconfigure

```bash
sudo dpkg-reconfigure jitsi-videobridge2
```

## Uninstall
```bash
sudo apt purge jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-prosody jitsi-meet-turnserver jitsi-meet-web jicofo jitsi-videobridge2
```

##

* [Video](https://www.youtube.com/watch?v=S43-A1N_COE)
* [Code](https://nerdonthestreet.com/wiki?find=Set+Up+Jibri+for+Jitsi+Recording%3Aslash%3AStreaming)

sudo -i

apt install linux-image-generic ffmpeg curl unzip software-properties-common

sudo apt remove linux-image-aws
sudo apt remove linux-image-*-aws
systemctl reboot

echo "snd_aloop" >> /etc/modules

curl -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt update
apt install google-chrome-stable

CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

mkdir -p /etc/opt/chrome/policies/managed
echo '{ "CommandLineFlagSecurityWarningsEnabled": false }' >>/etc/opt/chrome/policies/managed/managed_policies.json

apt install jibri

usermod -aG adm,audio,video,plugdev jibri

vim /etc/prosody/prosody.cfg.lua

Make sure to replace the domains with jitsi.softwareunderground.org


prosodyctl register jibri auth.jitsi.softwareunderground.org Jibr1P@ssw0rd
prosodyctl register recorder recorder.jitsi.softwareunderground.org Rec0rderP@ssw0rd

Passwords are in 1Password

vim /etc/jitsi/jicofo/sip-communicator.properties

org.jitsi.jicofo.jibri.BREWERY=JibriBrewery@internal.auth.jitsi.softwareunderground.org
org.jitsi.jicofo.jibri.PENDING_TIMEOUT=90

vim /etc/jitsi/meet/jitsi.softwareunderground.org-config.js


fileRecordingsEnabled: true,
liveStreamingEnabled: true,
hiddenDomain: 'recorder.jitsi.softwareunderground.org',

mkdir /recordings
chown jibri:jibri /recordings

jibri {
  // A unique identifier for this Jibri
  // TODO: eventually this will be required with no default
  id = ""
  // Whether or not Jibri should return to idle state after handling
  // (successfully or unsuccessfully) a request.  A value of 'true'
  // here means that a Jibri will NOT return back to the IDLE state
  // and will need to be restarted in order to be used again.
  single-use-mode = false
  api {
    http {
      external-api-port = 2222
      internal-api-port = 3333
    }
    xmpp {
      // See example_xmpp_envs.conf for an example of what is expected here
      environments = [
	      {
                name = "prod environment"
                xmpp-server-hosts = ["jitsi.softwareunderground.org"]
                xmpp-domain = "jitsi.softwareunderground.org"

                control-muc {
                    domain = "internal.auth.jitsi.softwareunderground.org"
                    room-name = "JibriBrewery"
                    nickname = "jibri-nickname"
                }

                control-login {
                    domain = "auth.jitsi.softwareunderground.org"
                    username = "jibri"
                    password = "fbYZgHijoxRrBReNFWjRW4kv"
                }

                call-login {
                    domain = "recorder.jitsi.softwareunderground.org"
                    username = "recorder"
                    password = "rEjBiyRWzcpFsZCrYD6Wsauz"
                }

                strip-from-room-domain = "conference."
                usage-timeout = 0
                trust-all-xmpp-certs = true
            }]
    }
  }
  recording {
    recordings-directory = "/recordings"
    # TODO: make this an optional param and remove the default
    finalize-script = ""
  }
  streaming {
    // A list of regex patterns for allowed RTMP URLs.  The RTMP URL used
    // when starting a stream must match at least one of the patterns in
    // this list.
    rtmp-allow-list = [
      // By default, all services are allowed
      ".*"
    ]
  }
  chrome {
    // The flags which will be passed to chromium when launching
    flags = [
      "--use-fake-ui-for-media-stream",
      "--start-maximized",
      "--kiosk",
      "--enabled",
      "--disable-infobars",
      "--autoplay-policy=no-user-gesture-required"
    ]
  }
  stats {
    enable-stats-d = true
  }
  webhook {
    // A list of subscribers interested in receiving webhook events
    subscribers = []
  }
  jwt-info {
    // The path to a .pem file which will be used to sign JWT tokens used in webhook
    // requests.  If not set, no JWT will be added to webhook requests.
    # signing-key-path = "/path/to/key.pem"

    // The kid to use as part of the JWT
    # kid = "key-id"

    // The issuer of the JWT
    # issuer = "issuer"

    // The audience of the JWT
    # audience = "audience"

    // The TTL of each generated JWT.  Can't be less than 10 minutes.
    # ttl = 1 hour
  }
  call-status-checks {
    // If all clients have their audio and video muted and if Jibri does not
    // detect any data stream (audio or video) coming in, it will stop
    // recording after NO_MEDIA_TIMEOUT expires.
    no-media-timeout = 30 seconds

    // If all clients have their audio and video muted, Jibri consideres this
    // as an empty call and stops the recording after ALL_MUTED_TIMEOUT expires.
    all-muted-timeout = 10 minutes

    // When detecting if a call is empty, Jibri takes into consideration for how
    // long the call has been empty already. If it has been empty for more than
    // DEFAULT_CALL_EMPTY_TIMEOUT, it will consider it empty and stop the recording.
    default-call-empty-timeout = 30 seconds
  }
}


wget -O - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
add-apt-repository https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
apt update
apt install adoptopenjdk-8-hotspot

vim /opt/jitsi/jibri/launch.sh

Replace `java` with `/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/bin/java`

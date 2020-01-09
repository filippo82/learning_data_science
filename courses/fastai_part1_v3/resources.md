fast.ai
=======

This is required for the `doc` function to work:

```
conda install nbformat nbconvert
```

Google Cloud Platform (GCP) setup [instructions](https://course.fast.ai/start_gcp.html)

```
export IMAGE_FAMILY="pytorch-latest-gpu" # or "pytorch-latest-cpu" for non-GPU instances
export ZONE="europe-west4-c"
export INSTANCE_NAME="my-fastai-instance"
export INSTANCE_TYPE="n1-highmem-8" # budget: "n1-highmem-4"

# budget: 'type=nvidia-tesla-k80,count=1'
gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator="type=nvidia-tesla-p4,count=1" \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=200GB \
        --metadata="install-nvidia-driver=True" \
        --preemptible
```

```
gcloud beta compute --project "algebraic-fin-232107" ssh --zone "europe-west4-c" "my-fastai-instance" -- -L 8080:localhost:8080
```

Articles
========

* Zeiler and Fergus, 2014, [Visualizing and UnderstandingConvolutional Networks](https://cs.nyu.edu/~fergus/papers/zeilerECCV2014.pdf)

Blog posts
==========

[Ten Techniques Learned From fast.ai](https://blog.floydhub.com/ten-techniques-from-fast-ai/)

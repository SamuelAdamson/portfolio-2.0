## api.
<br/>

the portfolio application requires multiple services to curate and display user metrics pertaining to github and leetcode. these services are designed to be hosted on google cloud platform.

### load_metrics.

the `load_metrics` service is a batch data update for metrics including github contributions, recent github repositories and leetcode problem solved count. this batch is packaged as an event-driven cloud run application triggered by a cron job (cloud scheduler) once a day. each time the batch runs, the user metrics data is overwritten entirely.

#### load_metrics - development.

ensure that you install the dependencies from the `requirements.txt` file (`pip install -r requirements.txt`). copy the `.env.default` file contents to a `.env` file and insert the information. 

_note_: you will need to create a [github personal access token](https://github.com/settings/tokens) for authenticated api usage

#### load_metrics - containerization.

this app is containerized using docker. for installation see [docker ubuntu installation](https://docs.docker.com/engine/install/ubuntu/).

the `load_metrics` service is deployed to cloud run. thus, we create a container for the `load_metrics` service using docker and docker compose. 

to build the docker image navigate to the `api/load_metrics` directory and run:
```
docker compose build
```

confirm that the docker image exists by running:
```
docker images
```

the image should be tagged `giibbu-portfolio-load-metrics`

_note_: the docker container is intended to be run from a deployed google cloud resource (cloud run), and thus the credentials of a service account are not explicitly defined in the container environment. you will need to specify google service account credentials to run the container locally.

#### load_metrics - deploy.

TODO

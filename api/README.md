## api
<br/>

the portfolio application requires multiple services to curate and display user metrics pertaining to github and leetcode. these services are designed to be hosted on google cloud platform (GCP).

### load_metrics

the `load_metrics` service is a batch data update for metrics including github contributions, recent github repositories, and leetcode problem solved count. this batch is packaged as an event-driven cloud run job triggered by a cron job (cloud scheduler) once a day. each time the batch runs, the user metrics data is overwritten entirely.

#### load_metrics (development)

ensure that you install the dependencies from the `requirements.txt` file (`pip install -r requirements.txt`). copy the `.env.default` file contents to a `.env` file and insert the information. 

_note_: the `.env` file is used solely for development environments. production environment (cloud run) environment variables should be configured in the infrastructure (see `infrastructure/` directory).

#### load_metrics (secrets)

in order to query github data, it is required to make an authenticated request to the github api using a [github personal access token](https://github.com/settings/tokens). this is a sensitive piece of authentication information. as such, it should be stored in a [secret manager](https://cloud.google.com/run/docs/configuring/services/secrets) in production.

_note_: all secrets are intended to be set up manually and not automated through terraform (see `infrastructure/` directory).

#### load_metrics (containerization)

this app is containerized using docker. for installation see [docker ubuntu installation](https://docs.docker.com/engine/install/ubuntu/).

the `load_metrics` script is deployed to cloud run job. thus, we create a container for the `load_metrics` job using docker and docker compose. 

to build the docker image navigate to the `api/load_metrics` directory and run:
```
docker compose build
```

confirm that the docker image exists by running:
```
docker images
```

the image should be tagged `giibbu-portfolio-load-metrics`

_note_: the docker container is intended to be run from a deployed google cloud resource (cloud run job), and thus the credentials of a service account are not explicitly defined in the container environment. you will need to specify google service account credentials to run the container locally.

#### load_metrics (upload container image to GCP)

before the docker container image can be used with google cloud resources like cloud run, the container image needs to be pushed to google container registry (GCR). [full tutorial](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling)

_first_, you must ensure that the artifact registry API is enabled in your project and create a docker image repository [simple instructions](https://cloud.google.com/artifact-registry/docs/repositories/create-repos).

_next_, ensure that you are authenticated to the gcr repository. you can do this using the following gcloud SDK command.

```
gcloud auth configure-docker
```

_next_, ensure that your local docker image is properly tagged for GCR.

```
docker tag <LOCALIMAGE_ID> <LOCATION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY>/<IMAGE>:<TAG>
```

where `LOCATION` is the location for our image repository configured in GCP.

_finally_, push your image to the GCR.

```
docker push <LOCATION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY>/<IMAGE>:<TAG>
```

_troubleshooting authentication_: a token may be required to authenticate to gcloud
```
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://<LOCATION>-docker.pkg.dev
```

### metrics

there are three metrics endpoints for serving github contributions, recent github repositories, and leetcode problem solved count. each of these endpoints follows the following pattern:

* github contributions -> `api.<BASE URL>/contributions/` link (TODO)
* leetcode problem solved count -> `api.<BASE URL>/repositories/` link (TODO)
* leetcode problem sovled count -> `api.<BASE URL>/solved/` link (TODO)

#### metrics (development)

TODO


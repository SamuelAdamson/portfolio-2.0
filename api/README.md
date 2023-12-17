## api.
<br/>

the portfolio application requires multiple services to curate and display user metrics pertaining to github and leetcode. these services are designed to be hosted on google cloud platform.

### load_metrics.

the `load_metrics` service is a batch data update for metrics including github contributions, recent github repositories and leetcode problem solved count. this batch is packaged as an event-driven cloud run application triggered by a cron job (cloud scheduler) once a day. each time the batch runs, the user metrics data is overwritten entirely.

#### load_metrics - development.

ensure that you install the dependencies from the `requirements.txt` file (`pip install -r requirements.txt`). copy the `.env.default` file contents to a `.env` file and insert the information. 

_note_: you will need to create a [github personal access token](https://github.com/settings/tokens) for authenticated api usage

#### load_metrics - containerization.

TODO

#### load_metrics - deploy.

TODO

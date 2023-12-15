# Samuel Adamson (giibbu)
# Portfolio Page
# Refresh -- Query

""" Helper functions for querying user metrics """

import os
import requests
import logging
from datetime import datetime, timedelta


def get_github_metrics() -> list:
    """ Get github commit metrics """

    username = os.environ.get("GH_USERNAME")
    token = os.environ.get("GH_TOKEN")

    last_year = _get_last_year()

    repos = _get_github_repos_since(username, token, last_year)


def get_leetcode_metrics():
    """ Todo """


def _get_last_year() -> datetime:
    """ Get last year's datetime """
    
    return datetime.now() - timedelta(days=365)


def _get_github_repos_since(
    username: str,
    token: str,
    since: datetime
) -> list[str] | None:
    """ Get a list of all repositories for a user which have been updated
    since a given date
    """

    api_url = "https://api.github.com/user/repos"

    since_str = since.strftime("%Y-%m-%dT%H:%M:%S%Z")
    params = {
        "since": since_str,
    }

    res = requests.get(api_url, auth=(username, token), params=params)

    if res.status_code == 200:
        
        data = res.json()
        repos = []

        for repo in data:

            if "full_name" not in repo:
                logging.error("Error! API schema has changed!")
                return None
            
            repos.append(repo["full_name"])

        return repos

    logging.error(f"Error! GitHub API request failed for {api_url}!")
    logging.error(f"{res.status_code} {res.text}")

    return None


def _get_commits_since(
    username: str,
    token: str,
    repo: str,
    since: datetime,
) -> list[str] | None:
    """ Get the commits by a user in a repository since a given date

    The username and token will be used to authenticate
    for private repos
    """

    api_url = f"https://api.github.com/repos/{repo}/commits"

    since_str = since.strftime("%Y-%m-%dT%H:%M:%S%Z")
    params = {
        "since": since_str,
        "committer": username,
        "per_page": 100,
    }

    res = requests.get(api_url, auth=(username, token), params=params)

    if res.status_code == 200:

        data = res.json()
        print(repo)
        print(data[5])

        return None

    logging.error(f"Error! GitHub API request failed for {api_url}!")
    logging.error(f"{res.status_code} {res.text}")

    return None

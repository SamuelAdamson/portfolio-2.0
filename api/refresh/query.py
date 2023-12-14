# Samuel Adamson (giibbu)
# Portfolio Page
# Refresh -- Query

""" Helper functions for querying user metrics """

import os
import requests
import logging


def get_github_metrics() -> list:
    """ Get github commit metrics """

    username = os.environ.get("GH_USERNAME")
    token = os.environ.get("GH_TOKEN")

    repos = _get_github_repos(username, token)




def get_leetcode_metrics():
    """ Todo """


def _get_github_repos(username: str, token: str) -> list[str] | None:
    """ Get a list of all repositories for a user """

    api_url = f"https://api.github.com/user/repos"

    res = requests.get(api_url, auth=(username, token))

    if res.status_code == 200:
        
        data = res.json()
        repos = []

        for repo in data:

            if "full_name" not in repo:
                logging.error("Error! API schema has changed!")
                return None
            
            repos.append(repo["full_name"])

        return repos

    logging.error("Error! GitHub API request failed!")
    logging.error(f"{res.status_code} {res.text}")

    return None

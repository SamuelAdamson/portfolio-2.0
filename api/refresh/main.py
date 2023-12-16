# Samuel Adamson (giibbu)
# Portfolio Page
# Refresh -- Main

""" Update Cloud Firestore with recent metrics """

import os
from .query import get_github_contributions, \
    get_github_repos, \
    get_leetcode_solved

from google.cloud import firestore


def refresh() -> None:
    """ Refresh daily metrics in Firestore """

    gh_username = os.environ.get("GH_USERNAME")
    gh_token = os.environ.get("GH_TOKEN")
    lc_username = os.environ.get("LC_USERNAME")

    gh_contributions = get_github_contributions(gh_username, gh_token)
    gh_repos = get_github_repos(gh_username, gh_token)
    lc_solved = get_leetcode_solved(lc_username)




if __name__ == "__main__":
    refresh()

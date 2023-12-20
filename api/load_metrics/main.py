# Samuel Adamson (giibbu)
# Portfolio Page
# Load Metrics -- Main

""" Update Cloud Firestore with user metrics """

import os
from query import get_github_contributions, \
    get_github_repos, \
    get_leetcode_solved

from google.cloud import firestore


# Firestore portfolio metrics collection and document names
COLLECTION = "portfolio_stats"
GH_CONTRIB_DOC = "gh_contributions"
GH_REPOS_DOC = "gh_repos"
LC_SOLVED_DOC = "lc_solved"


def load_metrics() -> None:
    """ Refresh daily metrics in Firestore """

    gh_username = os.environ.get("GH_USERNAME")
    gh_token = os.environ.get("GH_TOKEN")
    lc_username = os.environ.get("LC_USERNAME")

    gh_contributions = get_github_contributions(gh_username, gh_token)
    gh_repos = get_github_repos(gh_username, gh_token)
    lc_solved = get_leetcode_solved(lc_username)

    database = os.environ.get("FIRESTORE_DB")
    db = firestore.Client(database=database) # firestore client

    gh_contributions_doc = db.collection(COLLECTION).document(GH_CONTRIB_DOC)
    gh_repos_doc = db.collection(COLLECTION).document(GH_REPOS_DOC)
    lc_solved_doc = db.collection(COLLECTION).document(LC_SOLVED_DOC)

    _set_contents(gh_contributions_doc, gh_contributions)
    _set_contents(gh_repos_doc, gh_repos)
    _set_contents(lc_solved_doc, lc_solved)


def _set_contents(doc: firestore.DocumentReference, contents: dict):
    """ Set contents of a document in firestore """

    # overwrite existing contents
    doc.set(contents)


if __name__ == "__main__":
    load_metrics()

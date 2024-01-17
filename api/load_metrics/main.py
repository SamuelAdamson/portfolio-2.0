# Samuel Adamson (giibbu)
# Portfolio Page
# Load Metrics -- Main

""" Update Cloud Firestore with user metrics """

import os

from google.auth import default
from google.cloud import firestore

from query import get_github_contributions, \
    get_github_repos, \
    get_leetcode_solved


def load_metrics() -> None:
    """ Refresh daily metrics in Firestore """

    gh_username = os.environ.get("GH_USERNAME")
    gh_token = os.environ.get("GH_TOKEN")
    lc_username = os.environ.get("LC_USERNAME")

    database = os.environ.get("DB")
    collection = os.environ.get("COLLECTION")

    gh_contribs_doc_name = os.environ.get("GH_CONTRIBS_DOC")
    gh_repos_doc_name = os.environ.get("GH_REPOS_DOC")
    lc_solved_doc_name = os.environ.get("LC_SOLVED_DOC")

    # firestore client
    credentials, project = default()
    db = firestore.Client(project=project, database=database, credentials=credentials)

    # query data from external
    gh_contribs = get_github_contributions(gh_username, gh_token)
    gh_repos = get_github_repos(gh_username, gh_token)
    lc_solved = get_leetcode_solved(lc_username)    

    gh_contribs_doc = db.collection(collection).document(gh_contribs_doc_name)
    gh_repos_doc = db.collection(collection).document(gh_repos_doc_name)
    lc_solved_doc = db.collection(collection).document(lc_solved_doc_name)
    
    _set_contents(gh_contribs_doc, gh_contribs)
    _set_contents(gh_repos_doc, gh_repos)
    _set_contents(lc_solved_doc, lc_solved)


def _set_contents(doc: firestore.DocumentReference, contents: dict):
    """ Set contents of a document in firestore """

    # overwrite existing contents
    doc.set(contents)


if __name__ == "__main__":
    load_metrics()

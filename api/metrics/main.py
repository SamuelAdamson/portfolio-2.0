# Samuel Adamson (giibbu)
# Portfolio Page
# Metrics API Endpoint

""" Metrics API Endpoint """

import os
import logging
import flask

from google.cloud import firestore
from google.auth import default

def main(request: flask.Request) -> None:
    """ Handle API Request """

    database = os.environ.get("DB")
    collection = os.environ.get("COLLECTION")
    document = os.environ.get("DOCUMENT")

    # firestore client
    credentials, project = default()
    db = firestore.Client(project=project, database=database, credentials=credentials)

    # get data from firestore
    doc = db.collection(collection).document(document)
    data = _get_data(doc)

    return flask.jsonify(data)


def _get_data(doc: firestore.DocumentReference):
    """ Retrieve firestore document contents """

    snapshot = doc.get()

    if snapshot.exists:
        return snapshot.to_dict()
    
    logging.error(f"Failed to retrieve data from {doc.id}!")
    return None

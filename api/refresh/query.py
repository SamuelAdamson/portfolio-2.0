# Samuel Adamson (giibbu)
# Portfolio Page
# Refresh -- Query

""" Helper functions for querying user metrics """

import os
import requests
import logging
from datetime import datetime, timedelta
from time import sleep

def get_github_contributions() -> tuple[int, dict]:
    """ Get github contributions in the last year grouped by month """

    username = os.environ.get("GH_USERNAME")
    token = os.environ.get("GH_TOKEN")

    last_year = _get_last_year()
    
    total, months = _get_github_contributions_since(username, token, last_year)

    return total, months


def get_github_repos(max_len: int=12) -> list:
    """ Get github public repositories sorted by recency """


def get_leetcode_metrics():
    """ Todo """



def _get_github_contributions_since(
    username: str,
    token: str,
    since: datetime,
) -> tuple[int, dict] | tuple[None, None]:
    """ Get the contributions by a user since a given date 
    
    Returns : (total contributions, contributions by date)
    """

    api_url = f"https://api.github.com/graphql"

    query = f"""
    {{
        user(login: \"{username}\") {{
            contributionsCollection {{
                contributionCalendar {{
                    weeks {{
                        contributionDays {{
                            contributionCount
                            date
                        }}
                    }}
                }}
            }}
        }}
    }}
    """

    res = requests.post(api_url, json={"query": query}, auth=(username, token))

    if res.status_code == 200:
        
        months = _get_month_dict(since)

        data = res.json()
        calendar = data["data"]["user"][
            "contributionsCollection"]["contributionCalendar"]

        weeks = calendar["weeks"]
        total = 0

        for week in weeks:
            for day in week["contributionDays"]:
                
                date = datetime.strptime(day["date"], "%Y-%m-%d")
                if date < since:
                    continue

                total += day["contributionCount"]
                months[date.strftime("%Y-%m")] += day["contributionCount"]

        return total, months

    else:

        logging.error(f"GitHub API request failed for {api_url}!")
        logging.error(f"{res.status_code} {res.text}")

    return None, None


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

                logging.error(f"GitHub API schema has changed for {api_url}!")
                return None
            
            repos.append(repo["full_name"])

        return repos

    logging.error(f"GitHub API request failed for {api_url}!")
    logging.error(f"{res.status_code} {res.text}")

    return None

def _get_last_year() -> datetime:
    """ Get last year's datetime (start of day) """
    
    last_year = datetime.now() - timedelta(days=365)

    return datetime(last_year.year, last_year.month, last_year.day)


def _get_month_dict(since: datetime) -> dict[str, 0]:
    """ Get a dictionary of months from since date to a year after """

    m = datetime(since.year, since.month, 1)
    
    months = {
        m.strftime("%Y-%m"): 0,
    }

    for _ in range(12):

        if m.month == 12: # end of year, start at jan next year
            m = datetime(m.year + 1, 1, 1)
        
        else: # iterate month by 1
            m = datetime(m.year, m.month + 1, 1)

        months[m.strftime("%Y-%m")] = 0

    return months

get_github_contributions()

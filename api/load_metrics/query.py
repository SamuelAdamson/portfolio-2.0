# Samuel Adamson (giibbu)
# Portfolio Page
# Load Metrics -- Query

""" Helper functions for querying user metrics """

import requests
import logging
from datetime import datetime, timedelta


def get_github_contributions(gh_username: str, gh_token: str) -> dict:
    """ Get github contributions in the last year grouped by month """

    last_year = _get_last_year()
    
    total, months = _get_github_contributions_since(gh_username, gh_token, last_year)
    data = {"total": total, "months": months}

    return data


def get_github_repos(gh_username: str, gh_token: str, max_len: int=6) -> list:
    """ Get github public repositories sorted by recency """

    last_year = _get_last_year()

    repos = _get_github_repos_since(gh_username, gh_token, last_year)
    
    data = [
        {"name": repo[0], "url": repo[1]}
        for repo in repos
    ]

    return data


def get_leetcode_solved(lc_username: str) -> dict:
    """ Get number of solved hard, medium, and easy leetcode problems """

    data = _get_leetcode_problem_count(lc_username)

    return data


def _get_github_contributions_since(
    username: str,
    token: str,
    since: datetime,
) -> tuple[int, dict] | tuple[None, None]:
    """ Get the contributions by a user since a given date 
    
    Returns : (total contributions, contributions by date)
    """

    api_url = "https://api.github.com/graphql"

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
                year_month = date.strftime("%Y-%m")

                if year_month in months:
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
) -> list | None:
    """ Get a list of all repositories for a user which have been updated
    since a given date, sorted by most recently updated
    """

    api_url = "https://api.github.com/user/repos"

    since_str = since.strftime("%Y-%m-%dT%H:%M:%S%Z")
    params = {
        "since": since_str,
        "visibility": "public",
    }

    res = requests.get(api_url, auth=(username, token), params=params)

    if res.status_code == 200:
        
        data = res.json()
        repos = []

        for repo in data:

            if not (
                "full_name" in repo and "updated_at" in repo and "url" in repo
            ):

                logging.error(f"GitHub API schema has changed for {api_url}!")
                return None
            
            repos.append((repo["full_name"], repo["url"], repo["updated_at"]))

        sorted_repos = sorted(repos, key=lambda r: r[2], reverse=True)
        return [(repo[0], repo[1]) for repo in sorted_repos]

    logging.error(f"GitHub API request failed for {api_url}!")
    logging.error(f"{res.status_code} {res.text}")

    return None


def _get_leetcode_problem_count(username: str) -> dict[str, int] | None:
    """ Get leetcode problems grouped by difficulty """

    api_url = "https://leetcode.com/graphql"

    query = f"""
    {{
        matchedUser(username: \"{username}\") {{
            submitStats: submitStatsGlobal {{
                acSubmissionNum {{
                    difficulty
                    count
                    submissions
                }}
            }}
        }}
    }}
    """

    res = requests.post(api_url, json={"query": query})

    if res.status_code == 200:

        data = res.json()
        subs = data["data"]["matchedUser"]["submitStats"]["acSubmissionNum"]

        solved = {
            str(sub["difficulty"]).lower(): sub["count"]
            for sub in subs
        }

        return solved

    else:

        logging.error(f"Leetcode API request failed for {api_url}!")
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

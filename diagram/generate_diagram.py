import os
from urllib.request import urlretrieve
from diagrams import Diagram, Cluster, Edge
from diagrams.onprem.vcs import Github 
from diagrams.onprem.ci import GithubActions
from diagrams.custom import Custom

with Diagram("Action Functionality", direction='LR', show=False) as diag:
    action = GithubActions("Action")
    github = Github("github")

    input_image_url = "https://emojigraph.org/media/twitter/memo_1f4dd.png"
    input_icon = "input.png"
    urlretrieve(input_image_url, input_icon)

    with Cluster("Questions"):
        questions = [Custom("Q1 Code", input_icon),
                    Custom("Q2 Code", input_icon),
                    Custom("Q3 Code", input_icon)]

    with Cluster("Answers",):
        answers = [Custom("Q1 Answer", input_icon),
                    Custom("Q2 Answer", input_icon),
                    Custom("Q3 Answer", input_icon)]

    questions >> Edge(color="darkgreen", label="Pull Request") >> github >> action >> Edge(color="firebrick", label="Actions Output") >> answers

diag

os.remove("input.png")
# Samuel Adamson (giibbu)
# Portfolio Page
# Load Metrics -- Main

# import base image
FROM google/cloud-sdk:latest

# set working directory
WORKDIR /app

# copy source to working directory
COPY main.py .
COPY query.py .
COPY requirements.txt .

# install python (not present in cloud-sdk image)
RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install requirements
RUN pip install --no-cache-dir -r requirements.txt

# start execution
CMD ["python3", "main.py"]

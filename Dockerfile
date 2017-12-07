# Use an official ubuntu runtime as a parent image
FROM ubuntu:16.04
RUN apt-get update

# Setup locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install python
RUN apt-get install -y software-properties-common vim
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip
RUN apt-get install -y git
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel
RUN ln -s /usr/bin/python3.6 /usr/bin/python

# Install ffmpeg
RUN apt-get install -y ffmpeg

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /app
ADD . /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt
RUN python -c "import nltk; nltk.download('punkt')"

# Define environment variable
ENV NAME ModiFy

# Run app.py when the container launches
CMD ["python", "app.py"]

# Pull base image
from python:3.7

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code/

RUN apt update && apt upgrade -y && apt autoremove

# Setup Poetry
RUN pip install poetry

RUN /usr/local/bin/poetry config virtualenvs.in-project true

# Install dependenncies
RUN pip install pipenv

#Copy in config files and install dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry export -f requirements.txt --output requirements.txt
RUN pip install -r requirements.txt

#COPY . /code/

#RUN cat ./login_script.sh >> /root/.bashrc

EXPOSE 8000

#CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
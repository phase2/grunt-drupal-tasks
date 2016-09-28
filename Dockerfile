FROM python:3.4

RUN pip install mkdocs

RUN mkdir /documents
WORKDIR /documents

CMD mkdocs build --clean --site-dir /site

FROM python:2.7-alpine
RUN pip install Flask

EXPOSE 5000

ADD app /app
WORKDIR /app

CMD python main.py
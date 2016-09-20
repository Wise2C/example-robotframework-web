FROM python:2.7
ADD demoapp app
WORKDIR app
EXPOSE 7272
CMD python server.py

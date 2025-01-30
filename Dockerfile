FROM quay.io/jupyter/base-notebook

COPY requirements.txt /requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install -r /requirements.txt

EXPOSE 8888:8888

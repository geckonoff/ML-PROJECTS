FROM python:3.9.15
            
COPY requirements.txt /requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install -r /requirements.txt
    
RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR home/jupyter 
EXPOSE 8888                                           
ENTRYPOINT ["jupyter", "notebook","--allow-root","--ip=0.0.0.0","--port=8888","--no-browser"]

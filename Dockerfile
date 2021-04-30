FROM python:3.6-slim-jessie
# FROM debian:buster-slim
# FROM opencvcourses/opencv-docker:4.5.1


COPY . /app
WORKDIR /app

ENV JARVIS_PATH /usr/local/bin/jarvis

RUN apt update \
    && apt-get upgrade -y \
    && apt-get install -y \
        build-essential \
        gcc \
        xauth \
        ninja-build \
        python3-pip \
        python3-dev \
        python-dev \
        libssl-dev \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        python-dev \
        libevent-dev \
        cheese \
        wmctrl \
        libav-tools \
        htop \
        wkhtmltopdf \
        espeak \
        libnotify-bin \
        python3-pyaudio

RUN pip3 install --upgrade pip setuptools wheel\
    && pip3 install -v -v -v --upgrade -r installer/requirements.txt

RUN ls -al /dev \
    && cat /etc/group

RUN echo "python3 /app/jarviscli/" > "$JARVIS_PATH" \
    && chmod +x "$JARVIS_PATH" \
    && python -m nltk.downloader -d jarviscli/data/nltk wordnet \
    && usermod -a -G video root

ENTRYPOINT "/bin/sh" "$JARVIS_PATH"


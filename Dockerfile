FROM python:3.4-jessie

ARG http_proxy
ARG https_proxy
ARG verify_ssl=y

ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy
ENV verify_ssl=$verify_ssl

RUN apt-get update \
 && apt-get install -y ca-certificates wget git build-essential python-dev python-pip python-cffi libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info \
 && update-ca-certificates \
 && mkdir -p /root/.postmanerator/themes \
 && cd /root/.postmanerator/themes \
 && if [ "${verify_ssl}" = "n" ]; \
    then git config --global http.sslVerify "false"; \
    fi \
 && git clone https://github.com/aubm/postmanerator-default-theme.git default \
 && git clone https://github.com/zanaca/postmanerator-hu-theme.git hu \
 && git clone https://github.com/aubm/postmanerator-markdown-theme.git markdown \
 && cd /usr/bin/ \
 && if [ "${verify_ssl}" = "n" ]; \
    then wget -O postmanerator https://github.com/aubm/postmanerator/releases/download/v0.8.0/postmanerator_linux_386 --no-check-certificate; \
    else wget -O postmanerator https://github.com/aubm/postmanerator/releases/download/v0.8.0/postmanerator_linux_386; \
    fi \
 && chmod +x postmanerator \
 && mkdir -p /root/.postmanerator/themes/cohorte

RUN pip install WeasyPrint 

ENV REFRESHED_AT 20171003_1100

COPY callpostmanerator.sh /root
COPY ./theme/cohorte /root/.postmanerator/themes/cohorte

RUN chmod +x /root/callpostmanerator.sh

RUN ls -la /root
RUN ls -la /root/.postmanerator/themes/cohorte

ENTRYPOINT ["/root/callpostmanerator.sh"]
CMD ["-collection", "/usr/var/collection.json"]

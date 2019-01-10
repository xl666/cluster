FROM alpine:latest
 
RUN apk update && apk add rsync openssh-client && rm -rf /var/cache/apk/*

ENV CRONSTRING "* * * * *"
ENV RESPAL_DIR "/tmp"
ENV REMOTE_SERVER ""
ENV REMOTE_PORT "22"
ENV REMOTE_USER ""
ENV REMOTE_DIR ""
ENV RESTORE ""

COPY ./respaldar.sh /
RUN chmod 755 /respaldar.sh
COPY ./run.sh /
RUN chmod 755 /run.sh 

CMD /run.sh

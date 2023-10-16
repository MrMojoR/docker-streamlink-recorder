FROM python:3.12.0rc1-bullseye
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkCommit=51a9ba8d20b490b892d89412962f2ebc38d611d0
ENV PATH "${HOME}/.local/bin:${PATH}"

RUN apt-get update && apt-get install gosu && apt-get install python3-pip -y

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN  echo 'export PATH="${HOME}/.local/bin:${PATH}"'

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins
RUN mkdir /home/.config
RUN mkdir /home/.config/streamlink
RUN mkdir /home/.config/streamlink/config
RUN mkdir /home/.config/streamlink/plugins

#RUN git clone https://github.com/Damianonymous/streamlink-plugins.git
#RUN cp /streamlink-plugins/*.py /home/plugins/

RUN wget https://github.com/2bc4/streamlink-ttvlol/releases/latest/download/twitch.py
RUN cp twitch.py /usr/local/lib/python3.12/site-packages/streamlink/plugins/

COPY ./streamlink-recorder.sh /home/script/ 
#COPY ./config.twitch /home/.config/streamlink/config
COPY ./entrypoint.sh /home/script

#RUN streamlink --plugin-dirs /home/plugins

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions}  ${streamLink} ${streamQuality} ${streamName}

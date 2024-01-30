# vim:set ft=dockerfile:
FROM debian:12

ENV APP_VER=17.0

LABEL maintainer="Afonso Henrique Moreira Magalhaes <afonso@leucotron.com.br>"

ENV FREEPBX_VERSION 17.0
ENV ASTERISK_VERSION 20.5.2
ENV OPUS_CODEC asterisk-20.0/x86-64/codec_opus-20.0_current-x86_64

ADD rootfs /
COPY build-freepbx.sh /
COPY build-asterisk.sh /
COPY build-start.sh /
COPY build-postinstall.sh /
RUN /build-start.sh


### app ports
ENV APP_PORT_HTTP         80
ENV APP_PORT_HTTPS        443
ENV APP_PORT_PJSIP        5060
ENV APP_PORT_WEBRTC       8089
ENV APP_PORT_AMI          8088
ENV APP_PORT_RTP_START    10000
ENV APP_PORT_RTP_END      12000

### exposed ports
EXPOSE \
  ${APP_PORT_HTTP}/tcp \
  ${APP_PORT_HTTPS}/tcp \
  ${APP_PORT_PJSIP}/tcp \
  ${APP_PORT_PJSIP}/udp \
  ${APP_PORT_WEBRTC}/tcp \
  ${APP_PORT_AMI}/tcp \
  ${APP_PORT_RTP_START}-${APP_PORT_RTP_END}/tcp \
  ${APP_PORT_RTP_START}-${APP_PORT_RTP_END}/udp

VOLUME /var/lib/asterisk/sounds /var/spool/asterisk /var/log/asterisk /var/log/supervisor /etc/asterisk /var/www /var/lib/mysql

CMD ["/usr/bin/supervisord"]
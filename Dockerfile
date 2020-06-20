FROM node:13-alpine

WORKDIR /app

COPY node-sonos /app

RUN mkdir cache && \
  ln -s settings/settings.json && \
  deluser --remove-home node && \
  adduser -h /app -D -H sonosapi -u 1030 && \
  chown -R sonosapi:users static cache && \
  npm install --production && \
  rm -rf /tmp/* /root/.npm

EXPOSE 5005

USER sonosapi

HEALTHCHECK --interval=1m --timeout=2s \
  CMD curl -LSs http://localhost:5005 || exit 1

CMD npm start

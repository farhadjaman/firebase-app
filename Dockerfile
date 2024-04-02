FROM node:20-bullseye-slim

RUN apt update -y && apt install -y openjdk-11-jdk bash

RUN npm install -g firebase-tools

COPY . .

RUN npm --prefix ./functions install

# somehow the docker didn't see entrypoint.sh if I just copy it from the source folder however it does exist when checking with `ls la`
RUN echo '#!/bin/sh \n firebase emulators:start' > ./entrypoint.sh && \
    chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

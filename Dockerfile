FROM node:12-alpine

RUN apk add --no-cache \
        bash \
        curl \
        git \
        zip \
        jq \
        groff \
        python3 \
        coreutils \
    &&  apk --update add --virtual build-dependencies python3-dev \
    &&  curl -s -O https://bootstrap.pypa.io/get-pip.py \
    &&  python3 get-pip.py \
    &&  rm get-pip.py \
    &&  pip install --no-cache-dir awscli \
    &&  apk del build-dependencies \
    && find /usr/bin/ -name '*.pyc' -delete \
    && find /usr/lib/ -name '*.pyc' -delete \
    && yarn cache clean


# Setting working directory. 
WORKDIR /usr/src/app

# Installing dependencies
COPY package*.json ./
RUN npm install

# Copying source files
COPY . .

# Give permission to run script
RUN chmod +x ./wait-for-it.sh

# Build files
RUN npm run build

EXPOSE 3000

SHELL ["/bin/bash", "-c"]

# Running the app
CMD [ "npm", "start" ]
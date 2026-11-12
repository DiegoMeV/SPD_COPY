FROM --platform=linux/amd64 ubuntu:latest

RUN apt-get update && apt-get install -y libaio1t64 curl wget unzip && apt-get clean && \
    ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1

WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip && \
    unzip instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip && rm -f instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip && \
    cd /opt/oracle/instantclient_19_19 && rm -f *jdbc* *occi* *mysql* *mql1* *ipc1* *jar uidrvci genezi adrci && \
    echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf && ldconfig

# Set the Instant Client library paths
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient_19_19:${LD_LIBRARY_PATH}"

# Install node
RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.19.0
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install yarn package manager
RUN npm install -g yarn

WORKDIR /app
COPY package*.json ./
RUN yarn install 
COPY . .
RUN yarn run build
EXPOSE 3000
CMD [ "yarn","run","start" ]
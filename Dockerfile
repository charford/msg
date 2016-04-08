FROM node:0.10.43-slim
RUN apt-get update && apt-get install make g++ python-dev -y -q && apt-get clean
ADD bundle /
WORKDIR /bundle
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && cd programs/server && npm install
CMD ["node", "main.js"]

FROM node:14

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ADD . .

#local gensan
# RUN npm config set proxy http://192.168.36.35:3128
# RUN npm config set https-proxy http://192.168.36.35:3128

#server
RUN npm config set proxy http://172.16.1.6:3128
RUN npm config set https-proxy http://172.16.1.6:3128


RUN npm install

ENTRYPOINT ["/entrypoint.sh"]

# EXPOSE 4032

CMD ["npm", "run", "dev"]

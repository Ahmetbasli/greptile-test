FROM node:22.2.0 as builder

WORKDIR /app/medusa

COPY package.json .
RUN rm -rf node_modules
RUN apt-get update
RUN apt-get install -y python3
RUN npm install -g npm@latest
RUN npm install

COPY . . 
RUN npm run build

FROM node:22.2.0

WORKDIR /app/medusa

RUN mkdir dist
COPY package*.json ./
COPY src ./src
COPY entrypoint.sh .
# COPY .env .
COPY medusa-config.js .
COPY tsconfig*.json .
RUN apt-get update
RUN apt-get install -y python3
RUN npm install -g @medusajs/medusa-cli
RUN npm i --only=production

COPY --from=builder /app/medusa/dist ./dist

EXPOSE 9000

ENTRYPOINT ["/app/medusa/entrypoint.sh"]

CMD ["start"]
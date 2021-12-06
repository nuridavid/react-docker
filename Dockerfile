FROM node:16 as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

#New base image addition tells the docker file to sparate the two "blocks" and take something  (in this case the build folder) and use it in a new block/level. Taking build folder and running it in production server.
FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html


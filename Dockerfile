FROM node:10.11 AS build
WORKDIR  /app
ENV PATH  /app/node_modules/.bin:$PATH

COPY . /app


RUN npm install --silent
RUN npm run build
#production
FROM nginx:mainline-alpine
COPY ./default-nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

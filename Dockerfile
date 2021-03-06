# Stage 1
FROM node:10 as parcel-build
WORKDIR /app

# Install dependencies
COPY package.json .
#RUN npm install
RUN npm install -g parcel

# Bundle app source
COPY . .
RUN parcel build index.html

EXPOSE 1234
#CMD ["npm","run","test"]


# Stage 2 - the production environment with nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=parcel-build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


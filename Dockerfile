#first stage
FROM  node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# next phase
FROM nginx
# needed for AWS
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# autostart, niet nodig
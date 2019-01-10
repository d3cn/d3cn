# 构建阶段
FROM node:alpine as build-env

WORKDIR /d3cnapp

# 先生成依赖层（容量大，且不经常变动），再拷贝程序
COPY d3cnapp/package.json d3cnapp/yarn.lock ./
RUN yarn install

COPY . .
RUN yarn run build

# 发布阶段
FROM node:alpine

WORKDIR /app
COPY /d3cn/package.json /d3cn/package-lock.json ./
RUN npm install --registry=http://registry.npm.taobao.org && npm cache clean --force

COPY /d3cn .
COPY --from=build-env /d3cnapp/dist ./public

EXPOSE 8000
CMD [ "npm", "start" ]
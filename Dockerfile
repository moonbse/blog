FROM nginx:alpine as build

RUN apk add --update \
    wget
    
ARG HUGO_VERSION="0.125.2"
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin

COPY ./ /site
WORKDIR /site
RUN hugo 

EXPOSE 80 
# might have to change the baseURL, using default hugo server only here
CMD [ "hugo", "server", "--disableFastRender", "--buildDrafts", "--watch=false", "--disableLiveReload" ,"--bind", "0.0.0.0",  "--baseURL=https://blog.nirbhaysingh.org" , "--appendPort=false"]
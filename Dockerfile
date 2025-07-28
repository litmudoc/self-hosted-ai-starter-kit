FROM n8nio/n8n:latest

USER root

### Install necessary packages
RUN apk update && \
    apk add --no-cache \
    chromium \
    harfbuzz \
    freetype \
    ttf-freefont \
    nss

# 한글 폰트 설치
RUN mkdir /usr/share/fonts/nanumfont
RUN wget http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip
RUN unzip NanumFont_TTF_ALL.zip -d /usr/share/fonts/nanumfont
RUN rm NanumFont_TTF_ALL.zip
RUN fc-cache -f -v

### Set environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node

### Install Puppeteer
RUN npm install puppeteer
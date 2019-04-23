FROM frolvlad/alpine-glibc:alpine-3.9 AS prepare

ADD files /files

# gdrive-linux-x64 2.1.0
# https://github.com/gdrive-org/gdrive
RUN wget "https://drive.google.com/uc?id=1Ej8VgsW5RgK66Btb9p74tSdHMH3p4UNb&export=download" -O /files/bin/gdrive \
 && chmod a+x /files/bin/* \
 && /files/bin/gdrive version


FROM frolvlad/alpine-glibc:alpine-3.9

COPY --from=prepare /files /

RUN apk --no-cache add openssh-client git

VOLUME /src

WORKDIR /src

CMD ["gdrive-backup"]

FROM debian:10 AS builder
RUN apt-get update
RUN apt-get -y install autoconf automake gcc make curl gettext libcurl4 libcurl4-openssl-dev pkg-config libxml2-dev libgpgme-dev
WORKDIR src
ADD https://github.com/t-brown/mcds/archive/refs/tags/v1.6.tar.gz mcds.tar.gz
RUN tar xvz --strip-components=1 -f mcds.tar.gz
RUN aclocal
RUN autoconf
RUN automake
RUN ./configure --prefix=/usr
RUN make
RUN DESTDIR=/staged make install

FROM debian:10 AS runtime
RUN apt-get update
RUN apt-get -y install libcurl4 libgpgme11 libxml2 man-db
COPY --from=builder /staged /
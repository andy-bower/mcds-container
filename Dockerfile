# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) Copyright 2023-2024 Andrew Bower

FROM debian:12 AS builder
RUN apt-get update
RUN apt-get -y install autoconf2.69 automake gcc make curl gettext libcurl4 libcurl4-openssl-dev pkg-config libxml2-dev
WORKDIR src
ADD https://github.com/t-brown/mcds/archive/refs/tags/v1.6.tar.gz mcds.tar.gz
RUN tar xvz --strip-components=1 -f mcds.tar.gz
RUN aclocal
RUN autoconf
RUN automake
RUN ./configure --prefix=/usr
RUN make
RUN DESTDIR=/staged make install

FROM debian:12-slim AS runtime
RUN apt-get update && apt-get -y install libcurl4 libxml2
# For GPG integration:
#   RUN apt-get -y install libgpgme11
# For the man page:
#   RUN apt-get -y install man-db
COPY --from=builder /staged /

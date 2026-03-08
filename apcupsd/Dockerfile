ARG BUILD_FROM
FROM $BUILD_FROM

ENV PKGVERSION=3.14.14
ENV CHARSET="ISO8859-1"
ENV LANG="C"

# Build deps
RUN apk add --no-cache gd-dev \
                       libusb-compat-dev \
                       linux-headers \
                       mandoc \
                       net-snmp-dev \
                       patch \
                       make \
                       gcc \
                       musl-dev \
                       g++ \
                       util-linux

# Copy patch
COPY patches/*.patch /tmp/

# Build apcupsd w/ patch
RUN wget https://sourceforge.net/projects/apcupsd/files/apcupsd%20-%20Stable/$PKGVERSION/apcupsd-$PKGVERSION.tar.gz && \
    tar -xzf /apcupsd-$PKGVERSION.tar.gz && \
    cd apcupsd-$PKGVERSION && \
    for f in /tmp/*.patch ; do patch -p1 < $f ; done && \
    ac_cv_path_SHUTDOWN="/sbin/poweroff" \
    ./configure \
		--build=$CBUILD \
		--host=$CHOST \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-modbus-usb \
		--enable-usb \
		--enable-snmp \
		--enable-cgi && \
    make && \
    make install

# Copy data for app
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
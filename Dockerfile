FROM alpine as build-vendor
WORKDIR /var/www/gdc

COPY vendor vendor

FROM alpine as build-vendor-autoload
WORKDIR /var/www/gdc

COPY --from=build-vendor /var/www/gdc/vendor vendor

FROM alpine as build-php
WORKDIR /var/www/gdc

COPY public public
COPY var var
COPY --from=build-vendor-autoload /var/www/gdc/vendor vendor

FROM alpine AS build-public
WORKDIR /var/www/gdc

COPY --from=build-php /var/www/gdc/public /var/www/gdc/public

FROM alpine

COPY --from=build-public /var/www/gdc/public /var/www/gdc/public
COPY --from=build-php /var/www/gdc/vendor vendor

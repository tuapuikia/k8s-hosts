FROM ubuntu:20.04

COPY ./manage-etc-hosts.sh /usr/local/sbin/manage-etc-hosts.sh

ENTRYPOINT ["/usr/local/sbin/manage-etc-hosts.sh"]

CMD ["help"]

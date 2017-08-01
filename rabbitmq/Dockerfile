FROM rabbitmq:3.6-management

ADD ./etc+rabbitmq/rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD ./etc+rabbitmq/definitions.json /etc/rabbitmq/definitions.json

# Cookie file /var/lib/rabbitmq/.erlang.cookie must be accessible by owner only
#VOLUME ["/var/log/rabbitmq", "/var/lib/rabbitmq"]

CMD ["rabbitmq-server"]


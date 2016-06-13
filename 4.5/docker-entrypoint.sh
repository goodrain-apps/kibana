#!/bin/bash

[ $DEBUG ] && set -x

sleep ${PAUSE:-0}

ELASTICSEARCH_URL="http://${ELASTICSEARCH_HOST:-127.0.0.1}:${ELASTICSEARCH_PORT:-9200}"
NODE_OPTIONS="--max-old-space-size=250"

# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	if [ "$ELASTICSEARCH_URL" ]; then
		sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '$ELASTICSEARCH_URL'!" /opt/kibana/config/kibana.yml
	fi

	set -- gosu kibana "$@"
fi

exec "$@"

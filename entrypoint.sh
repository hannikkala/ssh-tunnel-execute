#!/usr/bin/env sh

if [ "$BYPASS_SSH_TUNNEL" = "" ]; then
  if [ "$SSH_USER_AND_HOST" = "" ]; then
      echo "Enviroment variable SSH_USER_AND_HOST is not set. Don't know where to set up the tunnel."
      exit 1
  fi

  if [ ! -f "/root/.ssh/id_rsa" ] && [ ! -f "/root/.ssh/config" ]; then
      echo "SSH key file /root/.ssh/id_rsa or /root/.ssh/config does not exist. Cannot start the tunnel."
      exit 1
  fi

  FORWARDS=

  for port in $SSH_FORWARD_PORTS; do
      FORWARDS="$FORWARDS -L $port "
  done

  autossh -f -T -N -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -oStrictHostKeyChecking=no $FORWARDS $SSH_USER_AND_HOST

  echo "Sleeping for 5 seconds to ensure SSH tunnel has enough time to set up."

  sleep 5
fi

exec "$@"
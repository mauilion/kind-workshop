#!/usr/bin/env bash

########################
# include the magic
########################
. demo/demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=200

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "


# put your demo awesomeness here
#if [ ! -d "stuff" ]; then
#  pe "mkdir stuff"
#fi

#pe "cd stuff"
if [ ! "$(docker ps -q -f name=buildenv)" ] ; then 
  pe "docker run -d --name=buildenv \
      -v /tmp:/tmp -v $PWD/go:/go/ \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v $PWD/.kube:/go/.kube \
      mauilion/kind-buildenv"
fi
pe "docker exec buildenv kind build node-image --image=local:latest"
pe "docker exec buildenv kind create cluster --image=local:latest"
pe "chmod +r .kube/*"
pe "export KUBECONFIG=.kube/kind-config-kind"
pe "kubectl get pods -A"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""

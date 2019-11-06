#!/usr/bin/env bash

########################
# include the magic
########################
. lib/demo-magic.sh


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

pe "docker run -d --name=buildenv \
    -v /tmp:/tmp -v $PWD:/go/ \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $PWD/.kube:/go/.kube \
    mauilion/kind-buildenv"
pe "docker exec buildenv -- GO111MODULE=on go get sigs.k8s.io/kind@v0.5.1"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""

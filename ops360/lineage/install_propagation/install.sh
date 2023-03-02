#!/usr/bin/bash

info(){
echo `date +%Y-%m-%d_%H:%M:%S` INFO:"$1"
}


for line in `cat config`; do export $line; done

mkdir -p $DOCKER_DIR/lineage/propagation

info "copying compose file"
envsubst < compose.yml > $DOCKER_DIR/lineage/propagation/compose.yml

info "making directories"

mkdir -p $AC_LOGDIR/lineage/queue
mkdir -p $DOCKER_DIR/lineage/propagation
mkdir -p $DOCKER_DIR/lineage/propagation/lineage_fails

info "copying services-logger.xml files"
cp resources/services-logger.xml $DOCKER_DIR/lineage/propagation

info "copying keystore file "
cp resources/certstore $DOCKER_DIR/lineage/propagation

info "bringing up service"
docker-compose -f $DOCKER_DIR/lineage/propagation/compose.yml up -d --force-recreate

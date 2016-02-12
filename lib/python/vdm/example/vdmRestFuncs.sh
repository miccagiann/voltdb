#!/bin/bash

export HOST="http://localhost:8000/api/1.0"

function get() {
    local command=( $1 )
    local instance=( $2 )
    echo command: $1, instance: $2
    uri="$HOST/$command/$instance"
    echo uri: $uri
    curl $uri
}

function post() {
    local command=( $1 )
    local data=( $2 )
    echo command: $1, data: $2
    cmd="curl -H \"Content-Type: application/json\" -X POST -d '$data' $HOST/$command/"
    echo $cmd
    curl -H "Content-Type: application/json" -X POST -d "$data" $HOST/$command/
}

function put() {
    local command=( $1 )
    local data=( $2 )
    local instance=( $3 )
    echo command: $1, data: $2
    cmd="curl -H \"Content-Type: application/json\" -X PUT -d '$data' $HOST/$command/$instance"
    echo $cmd
    curl -H "Content-Type: application/json" -X PUT -d "$data" $HOST/$command/$instance
}

function delete() {
    local command=( $1 )
    local data=( $2 )
    local instance=( $3 )
    echo command: $1, instance: $2
    cmd="curl -H \"Content-Type: application/json\" -X DELETE -d $data $HOST/$command/$instance"
    echo $cmd
    curl -H "Content-Type: application/json" -X DELETE -d $data $HOST/$command/$instance
}

#!/usr/bin/env bash

_nixos-container() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="list create destroy restart start stop status set-bind-mounts update login root-login run show-ip show-host-key"
    startstop_opts=$(nixos-container list)
    create_opts="--nixos-path --system-path --config --config-file --flake --ensure-unique-name --auto-start --bridge --port --host-address --local-address --use-host-network --enable-tun --bind --bind-ro --additional-capability"
    set_bind_mounts_opts="--bind --bind-ro"
    update_opts="--config"

    if [[ "$prev" == "nixos-container" ]]
    then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    if [[ $(echo "$opts" | grep "$prev") ]]
    then
        if [[ "$prev" == "start" || "$prev" == "stop" ]]
        then
            COMPREPLY=( $(compgen -W "${startstop_opts}" -- ${cur}) )
            return 0
        elif [[ "$prev" == "update" ]]
        then
            COMPREPLY=( $(compgen -W "${update_opts}" -- ${cur}) )
            return 0
        elif [[ "$prev" == "create" ]]
        then
            COMPREPLY=( $(compgen -W "${create_opts}" -- ${cur}) )
            return 0
        elif [[ "$prev" == "set-bind-mounts" ]]
        then
            COMPREPLY=( $(compgen -W "${startstop_opts}" -- ${cur}) )
            return 0
        fi
    fi

    if [[ " ${COMP_WORDS[*]} " == *" set-bind-mounts "* ]]
    then
        COMPREPLY=( $(compgen -W "${set_bind_mounts_opts}" -- ${cur}) )
        return 0
    fi
}

complete -F _nixos-container nixos-container

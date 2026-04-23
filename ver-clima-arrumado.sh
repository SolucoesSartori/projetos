#!/bin/bash

wttr() {
    # Define a localização padrão (Sao_Paulo) se nada for passado como argumento
    local location="${1:-Sao_Paulo}"
    local request="wttr.in/${location}?1Fq"

    # Se o terminal for estreito, adiciona o parâmetro 'n' (narrow) usando '&'
    if [ "$(tput cols)" -lt 125 ]; then
        request+="&n"
    fi

    # Executa o curl com tratamento de erro básico
    curl -H "Accept-Language: ${LANG%_*}" --compressed -s "$request"
}

# Chama a função
wttr "$@"

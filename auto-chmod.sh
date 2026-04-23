#!/usr/bin/env bash

PASTA="/root/scripts"

# Monitora criação ou modificação de arquivos na pasta
inotifywait -m -e create -e close_write "$PASTA" --format '%f' | while read ARQUIVO
do
    # Se o arquivo termina com .sh, aplica o chmod
    if [[ "$ARQUIVO" == *.sh ]]; then
        chmod +x "$PASTA/$ARQUIVO"
        # Opcional: remove caracteres do Windows automaticamente também
        sed -i 's/\r$//' "$PASTA/$ARQUIVO"
    fi
done

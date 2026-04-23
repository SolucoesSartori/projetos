#!/usr/bin/env bash

# Verifica se você passou algum arquivo como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 arquivo1.sh [arquivo2.sh ...]"
    exit 1
fi

# Loop para processar cada arquivo passado
for file in "$@"; do
    if [ -f "$file" ]; then
        sed -i 's/\r$//' "$file"
        chmod +x "$file"
        echo "✅ Corrigido e transformado em executável: $file"
    else
        echo "❌ Arquivo não encontrado: $file"
    fi
done

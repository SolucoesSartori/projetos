#!/usr/bin/env bash

# Função para exibir progresso visual
msg() {
    dialog --title "Debian 13 Setup" --infobox "$1" 5 50
    sleep 1
}

# 1. Verificar se o dialog está instalado (essencial para o script)
if ! command -v dialog &> /dev/null; then
    apt update && apt install dialog -y
fi

# 2. Início do Script Visual
dialog --title "Pós-Instalação Debian 13" \
--yesno "Deseja iniciar a atualização e configuração inicial do sistema?" 8 50

# Se o usuário escolher "Não" (status 1), sai do script
[ $? -ne 0 ] && exit

# 3. Atualização de Repositórios e Sistema
msg "Atualizando lista de repositórios e pacotes..."
apt update && apt full-upgrade -y

# 4. Instalação de Ferramentas Essenciais (Baseado no que usamos hoje)
msg "Instalando ferramentas essenciais (curl, wget, sed, inotify, git)..."
apt install curl wget sed inotify-tools git vim build-essential sudo -y

# 5. Configuração da sua pasta de scripts (caso não exista no novo sistema)
msg "Configurando estrutura de pastas..."
mkdir -p /root/scripts

# 6. Limpeza de pacotes desnecessários
msg "Limpando arquivos temporários e pacotes órfãos..."
apt autoremove -y && apt autoclean

# 7. Finalização
dialog --title "Sucesso!" --msgbox "Sistema atualizado e ferramentas instaladas com sucesso!\n\nLembre-se de configurar seu PATH no .bashrc se for um sistema novo." 10 50

clear

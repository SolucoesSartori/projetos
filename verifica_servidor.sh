#!/bin/bash

# =====================================================================
# Script de Verificação de Rotinas do Servidor
# Autor: Automatizado
# Descrição: Verifica disco, memória, rede e serviços.
# Wilson-Peninha 14/04/2026
# Versao 1.0.0.0
# =====================================================================

# Configurações
DATA=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)
LOG_FILE="/var/log/verificacao_diaria.log"
LIMIT_DISK=80 # Limite de uso de disco em %

# Cores para o console
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Início do Relatório
echo "========================================" | tee -a $LOG_FILE
echo "RELATÓRIO DE SAÚDE - $HOSTNAME - $DATA" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# 1. Verificação de Disco (/)
echo -e "\n${YELLOW}[+] Verificando Disco...${NC}" | tee -a $LOG_FILE
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -ge "$LIMIT_DISK" ]; then
    echo -e "${RED}AVISO: Espaço em disco acima de ${LIMIT_DISK}%! (Uso: ${DISK_USAGE}%)${NC}" | tee -a $LOG_FILE
else
    echo -e "${GREEN}Disco OK: ${DISK_USAGE}% em uso.${NC}" | tee -a $LOG_FILE
fi

# 2. Verificação de Memória (RAM)
echo -e "\n${YELLOW}[+] Verificando Memória RAM...${NC}" | tee -a $LOG_FILE
free -m | awk 'NR==2{printf "Total: %sMB | Usado: %sMB | Livre: %sMB | Uso: %.2f%%\n", $2,$3,$4,$3*100/$2}' | tee -a $LOG_FILE

# 3. Verificação de Serviços (Ex: nginx, mysql, ssh)
echo -e "\n${YELLOW}[+] Verificando Serviços...${NC}" | tee -a $LOG_FILE
SERVICES=("ssh" "cron") # Adicione seus serviços aqui
for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        echo -e "${GREEN}Serviço $SERVICE: Rodando${NC}" | tee -a $LOG_FILE
    else
        echo -e "${RED}Serviço $SERVICE: PARADO${NC}" | tee -a $LOG_FILE
    fi
done

# 4. Verificação de Rede (Conectividade Externa)
echo -e "\n${YELLOW}[+] Verificando Conectividade (Internet)...${NC}" | tee -a $LOG_FILE
if ping -c 1 8.8.8.8 &>/dev/null; then
    echo -e "${GREEN}Conexão de rede ativa.${NC}" | tee -a $LOG_FILE
else
    echo -e "${RED}Sem conexão com a internet!${NC}" | tee -a $LOG_FILE
fi

# 5. Usuários Logados
echo -e "\n${YELLOW}[+] Usuários Logados:${NC}" | tee -a $LOG_FILE
who | tee -a $LOG_FILE

echo -e "\n========================================" | tee -a $LOG_FILE
echo "Fim do relatório." | tee -a $LOG_FILE

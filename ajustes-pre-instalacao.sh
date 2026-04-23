# 1. Atualiza a lista de pacotes e o sistema
apt update && apt upgrade -y

# 2. Instala ferramentas essenciais (sudo, curl, vim, wget, mc )
apt install sudo curl vim mc wget openssh-server -y

# 3. Libera o Login de Root no SSH
# Altera 'prohibit-password' ou 'no' para 'yes' no arquivo de config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config

# 4. Reinicia o serviço SSH para aplicar as mudanças
systemctl restart ssh

# 5. Adiciona seu usuário comum ao grupo sudo (substitua 'seu_usuario')
# usermod -aG sudo seu_usuario

echo "Ajustes concluídos! Root liberado no SSH."
echo "Adiciona seu usuário comum ao grupo sudo."
echo "usermod -aG sudo seu_usuario."

# Habilita suporte a cores para ls e outros comandos
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color'
    alias ipa='ip -c a'
    alias curl='curl -L'
fi

# Variáveis de Cores para facilitar customização
AMARELO="\[\033[01;33m\]"
VERMELHO="\[\033[01;31m\]"
VERDE="\[\033[01;32m\]"
AZUL="\[\033[01;34m\]"
BRANCO="\[\033[00m\]"

# Prompt Informativo: [usuário@host] [diretório] $ 
# O caminho (\w) aparece em branco para destacar, e o símbolo $ em vermelho se for root
PS1="${VERDE}\u${AMARELO}@${AZUL}\h${BRANCO}:${AMARELO}[${BRANCO}\w${AMARELO}]${VERDE}\$ ${BRANCO}"

# Prompt limpo e funcional
if [ "$USER" = "root" ]; then
    # Vermelho para Root (Destaque para segurança)
    PS1="\u${BRANCO}@${AZUL}\h${BRANCO}:${AMARELO}\w${VERMELHO}# ${BRANCO}"
else
    # Verde para Usuário comum
    PS1="${VERDE}[\t] \u${BRANCO}@${AZUL}\h${BRANCO}:${AMARELO}\w${VERDE}$ ${BRANCO}"
fi

# Variaveis de Sistema
export PATH="$PATH:/root/scripts/"

# --- Rotina para ajuste de novo script que tenha erro de linha oriundos de windows e etc ---
# exp: /root/scripts/fix-script.sh novo-script.sh / sintaxe :  basta digitar limpar nome-do-script.sh
alias limpar='/root/scripts/fix-script.sh'

# Aliases Úteis para Programação e Scripts
# --- 4. ALIASES PARA PROGRAMADORES ---
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alF'
alias l='ls'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias gst='git status'
alias glog='git log --oneline --graph --all'
alias df='df -h'
alias free='free -m'
alias meuip='ip a; echo' # Mostra IP público rapidamente
alias myip='curl -sL -4 ifconfig.me/all' # Mostra IP público rapidamente
alias update='apt update && apt upgrade'
#alias ll='ls -la' # estava  ls -lah que mostra os lins simbolicos
alias scripts='cd ~/scripts 2>/dev/null || echo "Pasta ~/scripts não encontrada."'

# --- 5. FUNÇÕES ÚTEIS ---

# Cria um diretório e entra nele
mkcd() {
mkdir -p -- "$1" && cd -- "$1"
}


# Procura um texto em todos os arquivos do diretório atual
qgrep() {
    grep -rnI "$1" .
}

# Servidor HTTP rápido em Python para testar scripts/HTML
alias serve='python3 -m http.server 8080'

# --- 6. HISTÓRICO ---
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend # Anexa ao histórico em vez de sobrescrever
shopt -s checkwinsize # Atualiza o tamanho da janela após cada comando

# --- 7. EXTRAS ---
# Ativa o bash-completion se disponível
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
# Função para extrair qualquer arquivo compactado rapidamente
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "'$1' cannot be extracted via >extract<" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}


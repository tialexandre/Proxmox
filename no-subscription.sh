#!/bin/bash

# Backup do arquivo original do repositório
echo "Realizando backup do repositório original..."
cp /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak

# Desativar o repositório Enterprise
echo "Desativando o repositório Enterprise..."
echo "# deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise" > /etc/apt/sources.list.d/pve-enterprise.list

# Adicionar o repositório No-Subscription
echo "Adicionando o repositório No-Subscription..."
cat <<EOF > /etc/apt/sources.list.d/pve-no-subscription.list
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
EOF

# Atualizar pacotes
echo "Atualizando lista de pacotes..."
apt update

# Mensagem de conclusão
echo "Alteração para o repositório 'No-Subscription' concluída!"

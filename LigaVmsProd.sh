#!/bin/bash

# Lista todas as VMs
vms=$(/usr/sbin/qm list | awk '{print $1}')

# Loop para  listar cada VM 
for VMID in $vms; do

    # Caminho do arquivo de configuração da VM
    CONFIG_PATH="/etc/pve/qemu-server/${VMID}.conf"

    # Verifica se o arquivo de configuração contém a palavra "00-prod"
    if grep -q "00-prod" "$CONFIG_PATH"; then
    echo "A palavra '00-prod' foi encontrada no arquivo de configuração da VM $VMID."

    # Verifica o status da VM (usando o comando qm) 
    VM_STATUS=$(/usr/sbin/qm status $VMID | awk '{print $2}')

    if [ $VM_STATUS  = "stopped" ]; then
        echo "A VM $VMID está desligada. Iniciando..."
        /usr/sbin/qm start $VMID
    else
        echo "A VM $VMID já está em execução."
    fi
else
    echo "A palavra '00-prod' não foi encontrada no arquivo de configuração da VM $VMID."
fi
done

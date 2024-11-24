#!/bin/bash

# Lista todas as interfaces de rede
interfaces=$(ls /sys/class/net)

echo "Verificando as interfaces de rede ativas e suas velocidades:"
echo "------------------------------------------------------------"

for iface in $interfaces; do
    # Verifica se a interface está ativa
    if [[ $(cat /sys/class/net/$iface/operstate) == "up" ]]; then
        # Obtém a velocidade da interface usando ethtool
        speed=$(ethtool $iface 2>/dev/null | grep -i "Speed" | awk '{print $2}')
        
        # Verifica se a velocidade foi obtida com sucesso
        if [[ -n $speed ]]; then
            echo "Interface: $iface - Ativa - Velocidade: $speed"
        else
            echo "Interface: $iface - Ativa - Velocidade: Não disponível"
        fi
    else
        echo "Interface: $iface - Inativa"
    fi
done

echo "------------------------------------------------------------"

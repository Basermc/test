#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Recoge las variables desde Jenkins
namespace=${NAMESPACE}
group_size=${GROUP_SIZE}
project=${PROJECT}


# Validate group size
if [ $group_size -gt 20 ]; then
    echo -e "${RED}Error:${NC} Group size cannot be greater than 20."
    exit 1
fi

# Obtiene una lista de todos los despliegues en el namespace
deployments=($(oc get dc -n $namespace -o jsonpath='{.items[*].metadata.name}'))

# Define el contador
counter=0

# Define el índice del despliegue actual
index=0

# Obtiene el número total de despliegues
total_deployments=${#deployments[@]}


# Itera mientras queden despliegues por reiniciar
while [ $index -lt $total_deployments ]; do
    # Reinicia el despliegue actual
    if ! oc rollout latest -n $namespace dc/${deployments[$index]}; then
        echo -e "${RED}Error:${NC} Deployment ${deployments[$index]} failed."
    fi
    counter=$((counter+1))
    index=$((index+1))
    # Si el contador alcanza el tamaño del grupo o no quedan más despliegues por reiniciar, espera antes de continuar
    if [ $counter -eq $group_size ] || [ $index -eq $total_deployments ]; then
        counter=0
        # espera hasta que se complete el despliegue anterior
        oc rollout status -w -n $namespace dc/${deployments[$index-1]}
        #sleep 10s
    fi
done

# Success message
echo -e "${BLUE}Deployment completed successfully!${NC}"


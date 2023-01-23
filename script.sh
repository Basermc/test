#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Recoge las variables desde Jenkins
namespace=${NAMESPACE}
group_size=${GROUP_SIZE}
project=${PROJECT}

oc login -u system:admin -n $project



while getopts s:t:p:i:l:g: flag; do
  case "${flag}" in
  s) server=${OPTARG} ;;
  t) token=${OPTARG} ;;
  p) project=${OPTARG} ;;
  i) interval=${OPTARG} ;;
  l) label=${OPTARG} ;;
  esac
done


echo "Project: $project"
echo "Group size: $group_size"

oc login -u system:admin -n ${project}

deployments="./oc.exe get deploymentconfig -o name  -l '$label'"
values=$(eval "$deployments")

# Define the counter and total number of deployments
counter=0
total_deployments=${#values[@]}

for dc in ${values}
do
   echo "Restart $dc "
   pod="$(cut -d'/' -f2 <<<$dc)"
   # Validate that the total number of deployments does not exceed 20
   if [ $counter -lt 20 ]; then
        sleep $interval
        # Check the counter value before restarting
        if [ $(($counter % 2)) -eq 0 ]; then
            oc rollout latest  $dc
            oc rollout.exe status $dc --timeout=10m
        else
            oc rollout latest  $dc
            oc rollout status $dc --timeout=10m
        fi
        counter=$((counter+1))
   else
        echo "Total number of deployments exceeded 20"
        exit 1
   fi
done
oc delete pods --field-selector status.phase!=Running

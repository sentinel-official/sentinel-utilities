#!/bin/bash

ENCMETHOD=AES-256-CBC

deploy() {
  ip=$1; password=$2;
  echo $ip $password
  if [ ! -d "nodes/$ip" ]; then
    mkdir -p nodes/$ip
    keys=($(python3 ../keys.py))
    address=${keys[0]}
    private_key=${keys[1]}
    price=$(((RANDOM%100)+50))
    echo $private_key > nodes/$ip/private_key.txt
    echo '{"account_addr": "'${address}'", "price_per_gb": '${price}', "token": "", "enc_method": "'${ENCMETHOD}'"}' > nodes/$ip/config.data
  fi
  sshpass -p $password scp -o StrictHostKeyChecking=no nodes/$ip/config.data run.sh root@$ip:/root
  sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip 'sh run.sh'
}

deploy_many() {
  ip_file=$1
  passwords_file=$2
  ips=($(cat $ip_file))
  passwords=($(cat $passwords_file))
  ips_count=${#ips[@]}
  for index in ${!ips[*]}; do
    deploy ${ips[$index]} ${passwords[$index]}
  done
}

status() {
  ip=$1; password=$2;
  echo $ip $password
  sshpass -p $password ssh -o StrictHostKeyChecking=no root@$ip 'docker ps -a'
}

status_many() {
  ip_file=$1
  passwords_file=$2
  ips=($(cat $ip_file))
  passwords=($(cat $passwords_file))
  ips_count=${#ips[@]}
  for index in ${!ips[*]}; do
    status ${ips[$index]} ${passwords[$index]}
  done
}

case $1 in
  --deploy)
    shift
    deploy $@
    ;;
  --deploy-many)
    shift
    deploy_many $@
    ;;
  --status)
    shift
    status $@
    ;;
  --status-many)
    shift
    status_many $@
    ;;
  *)
    echo "Invalid parameters."
    exit 1
    ;;
esac

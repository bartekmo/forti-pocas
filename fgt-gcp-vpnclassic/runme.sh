gcloud deployment-manager deployments create gcp-vpn-pocas --config config.yaml
wait 60
gcloud compute vpn-tunnels describe fortidemo-cloudvpn-tunnel
gcloud compute instances tail-serial-port-output fortidemo-client

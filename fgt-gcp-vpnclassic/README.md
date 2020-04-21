PoCaS (Proof-of-Concept-as-Script)
# VPN from Fortigate behind NAT to GCP CloudVPN Classic
This script deploys resources to demonstrate ability of building a working IPSec VPN between a cluster of Fortigate devices located behind a 1-1 NAT and GCP CloudVPN gateway (classic).

## Prerequisites
None

## PoC Steps
Main steps of this PoC are fully provided by the runme script
1. Deploy the resources
```
gcloud deployment-manager deployments create gcp-vpn-pocas --config config.yaml
```
2. Give it a minute and check the status of the VPN tunnel:
```
gcloud compute vpn-tunnels describe fortidemo-cloudvpn-tunnel
```
3. Verify the actual connectivity by checking client's serial console output (the client instance is constantly pinging the server):
```
gcloud compute instances tail-serial-port-output fortidemo-client
```

## Optional Steps
In order to verify HA failover few additional steps related to HA deployment need to be taken care of manually:
4. After the deployment, log into the primary unit using its instance id as a password and change the password
5. Make sure both cluster nodes are in sync (`get sys ha status`)
6. Remove the ephemeral public IP from nic0 of secondary device:
```
gcloud compute instances delete-access-config fortidemo-fgt2 --zone europe-west1-c --access-config-name="Temporary External"
```

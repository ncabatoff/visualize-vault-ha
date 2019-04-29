# Visualize Vault HA

## Postgres Backend

![Image of dashboard](./dashboard.png)

This depends on the not yet merged [#5731](https://github.com/hashicorp/vault/pull/5731).
To visualize this, ensure you have docker-compose and Go 1.12 in your path then:

1. ```cd ~/workdir```
2. ```git clone -b postgres-ha-support https://github.com/bjorndolk/vault```
3. ```cd vault && XC_OSARCH=linux/amd64 make dev```
4. ```cd ~/workdir```
5. ```git clone https://github.com/ncabatoff/visualize-vault-ha```
6. ```cd visualize-vault-ha/postgres```
7. ```cp ../../vault/bin/vault ./vault/bin```
8. ```./launch.sh```
9. go to http://admin:admin@localhost:3000

./launch.sh will run docker-compose which will run:
- postgres for storage
- consul for service discovery
- prometheus, consul-exporter for metrics
- grafana for visualization
- vault with file backend and transit engine enabled for auto-unsealing other vaults
- vault1, vault2: vaults using postgres as an HA backend
- a client

vault1 and vault2 are run in such a way that they get killed and restarted regularly.

client constantly asks Consul for a healthy vault to talk to, then sends that vault a KV PUT.

When done, use

```bash
cd ~/workdir/visualize-vault-ha/postgres && docker-compose down
```

to stop the containers.
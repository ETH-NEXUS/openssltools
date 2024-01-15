# Openssl Tools
## Getting started
1. Create a root ca
```bash
otca create root
```
2. Create intermediate ca
```bash
otca create int
```
3. Create a server certificate
```bash
otca create server <servername>
```
4. Pack the certificates
```bash
otca pack <servername>
```
5. Use the certificates in your application


## Docker
1. Build the image: `docker build --platform linux/amd64 --no-cache -t ca .`
2. Create named volume for perisisting our config: `docker volume create ca_generator_config`
3. Run the image: `docker run -it --name ca_cont -v ca_generator_config:/tool/conf -v ./custom_ca:/CA ca bash`
4. Modify the `root_ca.cnf`: Navigate to `req_distinguished_name` and change the defaults under `# Optionally, specify some defaults.`
5. Modify the `int_ca.cnf`: Navigate to `req_distinguished_name` and change the defaults under `# Optionally, specify some defaults.`
6. Run `otca create root` to create the root authority. This will create a root certificate in the `/CA` folder as specified in  `config.sh`.
7. Run `otca create int` to create the intermediate cert. This will create an intermediate certificate in the `/CA` folder as specified in  `config.sh`.
8. Run `otca create server server_hostname` to create the server certificate.
9. Finally run `otca chain server_hostname.chain server_hostname int ca` to create the full certificate chain. The full chain can be found in `/CA/int/certs`


#### How do I persist my configuration?
Run the contianer with the following volume: `-v ./conf:/tool/conf`

#### How do I persist my generated certs/keys?
Run the container with the following volume: `-v ./custom_ca:/CA`

#### How do I use SANs in my certs?
1. Make sure to search for the `server_cert_alt` value in `conf/int_ca.cnf` and modify the `subjectAltName` key value to your needs.
2. Run the `otca create server server_hostname server_cert_alt`. The last param. signals that the script should use the values under `server_cert_alt`.
# SSL Setup


### 1. Create Certificate Authority
```shell script
 export CA_AUTHORITY_CN="MyCAauthority"
 sh ca_authority.sh
``` 

### 2. Generate Server Certificates

```shell script
 export SERVER_CN="kafka"
 export SERVER_KEY_PASS="serverpassword"
 sh generate_server_certificate.sh
```

### 3. Generate Client Certificates

```shell script
 export CLIENT_KEY_PASS="clientpassword"
 sh generate_client_certificate.sh
``` 

### 4. Build sample spring boot image
```shell script
cd ./kafka-rest-client
mvn clean install docker:build
```
### 5. Run broker and sample application
```shell script
docker-compose up -d 
```

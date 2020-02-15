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

### 4. Build and Run:
```shell script
mvn clean install docker:build
docker-compose up -d 
```

# SSL Setup


### 1. Create Certificate Authority
```shell script
 export CA_AUTHORITY_CN="Some Authority"
 sh ca_authority.sh
``` 

### 2. Generate Server Certificates

```shell script
 export SERVER_CN="Host Name"
 export SERVER_KEY_PASS="SomePassword"
 sh generate_server_certificate.sh
```

### 3. Generate Client Certificates

```shell script
 export SERVER_CN="Host Name"
 export SERVER_KEY_PASS="SomePassword"
 sh generate_client_certificate.sh
``` 

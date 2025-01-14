# iwantmyname-ddns

Docker image for Dynamic DNS for you iwantmyname domains: https://iwantmyname.com/blog/ddns-dynamic-dns-service-on-your-own-domain.

## API

Set the following environment variables:

- USERNAME: iwantmyname username (required)
- PASSWORD: iwantmyname password (required)
- HOSTNAME: dns hostname to set ip on (required)
- INTERVAL: interval to update hostname, if <= 0 then update hostname once, if > 0 then update hostname every INTERVAL seconds (optional)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iwantmyname-ddns
  namespace: {{namespace}}
  labels:
    app.kubernetes.io/name: iwantmyname-ddns
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: iwantmyname-ddns
  template:
    metadata:
      labels:
        app.kubernetes.io/name: iwantmyname-ddns
    spec:
      containers:
        - name: iwantmyname-ddns
          image: travisjeffery/iwantmyname-ddns:0.0.3
          env:
            - name: INTERVAL
              value: "3600"
            - name: USERNAME
              valueFrom:
                secretKeyRef:
                  name: iwantmyname-credentials
                  key: username
            - name: PASSWORD
              valueFrom:
                secretKeyRef:
                  name: iwantmyname-credentials
                  key: password
---
apiVersion: v1
kind: Secret
metadata:
  name: iwantmyname-credentials
  namespace: {{namespace}}
type: Opaque
data:
  username: {{username}}
  password: {{password}}
```

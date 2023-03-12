#!/bin/bash
kubectl apply -f traefik-role.yml -f traefik-deploy.yml -f db.yml
echo "Waiting 10s for database to start..."
sleep 10
cat initdb/cv.sql | kubectl exec -i $(kubectl get pods -l app=np-db --output=jsonpath={.items..metadata.name}) -- env PGPASSWORD=passwd psql -U natural-presence -d natural-presence
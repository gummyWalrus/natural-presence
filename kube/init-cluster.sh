#!/bin/bash
kubectl apply -f traefik-role.yml -f traefik-deploy.yml -f db.yml
echo "Waiting 10s for database to start..."
sleep 30
kubectl exec $(kubectl get pods -l app=np-db --output=jsonpath={.items..metadata.name}) -- env PGPASSWORD=passwd psql -U natural-presence natural-presence < initdb/cv.sql
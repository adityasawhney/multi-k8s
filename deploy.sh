docker build -t adityasawhney/multi-client:latest -t adityasawhney/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adityasawhney/multi-server:latest -t adityasawhney/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adityasawhney/multi-worker:latest  -t adityasawhney/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push adityasawhney/multi-client:latest
docker push adityasawhney/multi-server:latest
docker push adityasawhney/multi-worker:latest
docker push adityasawhney/multi-client:$SHA
docker push adityasawhney/multi-server:$SHA
docker push adityasawhney/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=adityasawhney/multi-client:$SHA
kubectl set image deployments/server-deployment server=adityasawhney/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=adityasawhney/multi-worker:$SHA
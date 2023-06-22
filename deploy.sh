
docker build -t shayunited21/multi-client:latest -t shayunited21/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shayunited21/multi-server:latest -t shayunited21/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shayunited21/multi-worker:latest -t shayunited21/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shayunited21/multi-client:latest
docker push shayunited21/multi-server:latest
docker push shayunited21/multi-worker:latest

docker push shayunited21/multi-client:$SHA
docker push shayunited21/multi-server:$SHA
docker push shayunited21/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=shayunited21/multi-server:$SHA
kubectl set image deployments/client-deployment client=shayunited21/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shayunited21/multi-worker:$SHA
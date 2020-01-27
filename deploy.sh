docker build -t hiranthadocker/multi-client:latest -t hiranthadocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hiranthadocker/multi-server:latest -t hiranthadocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hiranthadocker/multi-worker:latest -t hiranthadocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hiranthadocker/multi-client:latest
docker push hiranthadocker/multi-server:latest
docker push hiranthadocker/multi-worker:latest

docker push hiranthadocker/multi-client:$SHA
docker push hiranthadocker/multi-server:$SHA
docker push hiranthadocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hiranthadocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=hiranthadocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hiranthadocker/multi-worker:$SHA
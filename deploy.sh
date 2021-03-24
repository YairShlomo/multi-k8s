docker build -t ya1rd0cker/multi-client-k8s:latest -t ya1rd0cker/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ya1rd0cker/multi-server-k8s:latest -t ya1rd0cker/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t ya1rd0cker/multi-worker-k8s:latest -t ya1rd0cker/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ya1rd0cker/multi-client-k8s:latest
docker push ya1rd0cker/multi-server-k8s:latest
docker push ya1rd0cker/multi-worker-k8s:latest

docker push ya1rd0cker/multi-client-k8s:$SHA
docker push ya1rd0cker/multi-server-k8s:$SHA
docker push ya1rd0cker/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ya1rd0cker/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=ya1rd0cker/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ya1rd0cker/multi-worker-k8s:$SHA
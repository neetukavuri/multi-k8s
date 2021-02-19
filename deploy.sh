docker build -t nkavuri/multi-client:latest -t nkavuri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nkavuri/multi-server:latest -t nkavuri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nkavuri/multi-worker:latest -t nkavuri/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nkavuri/multi-client:latest
docker push nkavuri/multi-server:latest
docker push nkavuri/multi-worker:latest

docker push nkavuri/multi-client:$SHA
docker push nkavuri/multi-server:$SHA
docker push nkavuri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nkavuri/multi-server:$SHA
kubectl set image deployments/client-deployment client=nkavuri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nkavuri/multi-worker:$SHA
docker build -t ajuljulian/multi-client:latest -t ajuljulian/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajuljulian/multi-server:latest -t ajuljulian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajuljulian/multi-worker:latest -t ajuljulian/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajuljulian/multi-client:latest
docker push ajuljulian/multi-server:latest
docker push ajuljulian/multi-worker:latest

docker push ajuljulian/multi-client:$SHA
docker push ajuljulian/multi-server:$SHA
docker push ajuljulian/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ajuljulian/multi-client:$SHA
kubectl set image deployments/server-deployment server=ajuljulian/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ajuljulian/multi-worker:$SHA
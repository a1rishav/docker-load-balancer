
docker build -t py-centos:bases -f dockerfile-bases .
docker build -t flask-calc:release-v1 -f dockerfile .


docker run -d --name py-calc-1 -v /root/docker-load-balancer/application:/tests -e FLASKHOSTNAME='0.0.0.0' -e FLASKPORT=4500 -p 4500:4500 flask-calc:release-v1
docker run -d --name py-calc-2 -v /root/docker-load-balancer/application:/tests -e FLASKHOSTNAME='0.0.0.0' -e FLASKPORT=4501 -p 4501:4501 flask-calc:release-v1
docker run -d --name py-calc-3 -v /root/docker-load-balancer/application:/tests -e FLASKHOSTNAME='0.0.0.0' -e FLASKPORT=4502 -p 4502:4502 flask-calc:release-v1
docker run -d --name py-calc-4 -v /root/docker-load-balancer/application:/tests -e FLASKHOSTNAME='0.0.0.0' -e FLASKPORT=4503 -p 4503:4503 flask-calc:release-v1

docker network create calc-network
docker network connect calc-network py-calc-1
docker network connect calc-network py-calc-2
docker network connect calc-network py-calc-3
docker network connect calc-network py-calc-4

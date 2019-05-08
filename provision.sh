#Tool
sudo yum -y install vim git

if ! type docker > /dev/null 2>&1; then
#Docker
sudo curl -sSL https://get.docker.com/ | sh
sudo systemctl enable docker
sudo gpasswd -a vagrant docker
sudo systemctl start docker
fi

if ! type docker-compose > /dev/null 2>&1; then
#Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
fi

cd /vagrant_data
docker build -t django2.2 -f ./django/Dockerfile.base ./django

cd /vagrant_data/django
if [ ! -e test_project ]; then
docker run --rm \
--mount type=bind,src=$(pwd),dst=/opt/apps \
django2.1 \
django-admin startproject test_project .
fi

# cd /vagrant_data
# /usr/local/bin/docker-compose up --build -d

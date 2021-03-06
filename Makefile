#Miguel Angel Garcia Villegas

#Makefile

despliegue:
	chmod a+x variables.sh
	. ./variables.sh	

	chmod a+x despliegue5.sh
	./despliegue5.sh pass=$PASSW user=$USERN nomMaq=$MAQSER

installa:
	sudo pip install -r requirements.txt

clean:
	rm -rf *~* && find . -name '*.pyc' -exec rm {} \;

install:
	sudo apt-get update
	sudo apt-get install -y libmysqlclient-dev
	sudo apt-get install -y python-dev
	sudo apt-get install -y libjpeg8-dev
	sudo apt-get install -y libtiff4-dev
	sudo apt-get install -y zlib1g-dev
	sudo apt-get install -y libfreetype6-dev
	sudo apt-get install -y liblcms1-dev
	sudo apt-get install -y libwebp-dev
	sudo apt-get install -y python-pip
	sudo pip install --upgrade -y pip
	sudo pip install -r requirements.txt

test:
	export DJANGO_SETTINGS_MODULE=InsertaLogo.settings && nosetests

run:
	- python manage.py runserver
doc:
	- pycco *.py

heroku:
	wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
	heroku login
	heroku create
	git add .
	git commit -m "Despliegue heroku"
	git push heroku master
	heroku ps:scale web=1
	heroku open

docker:
	sudo apt-get update
	sudo apt-get install -y docker.io
	sudo docker pull magvugr/insertalogo
	sudo docker run -p 8000:8000 -t -i magvugr/insertalogo /bin/bash


#!/bin/bash

# 1. Mise à jour du système
sudo yum update -y

# 2. Installer Git, Java JDK 21
sudo yum install -y git java-21-amazon-corretto

# 3. Cloner le dépôt du service web
cd /home/ec2-user
rm -rf service-web
git clone https://github.com/mathieu55/ind250-Artifact service-web

# 4. Déplacer les fichiers nécessaires
cd /home/ec2-user/service-web/WebServer

JAR_FILE=$(ls WebServer-*.jar 2>/dev/null | head -n 1)
if [ -z "$JAR_FILE" ]; then
    echo "Erreur : Aucun fichier JAR trouvé dans WebServer."
    exit 1
fi

# 5. Configurer les variables d'environnement et exécuter l'application
export WEBSERVER_PORT=80
export WEBSERVER_CRYPTOPROTOCOL=http
export WEBSERVER_CRYPTOSERVER=licence.team1.gti778.ets.bimweb.net
export WEBSERVER_CRYPTOSERVERPORT=9090
export WEBSERVER_CRYPTOLICENCE=6d006006b023bb228e8b2c589416bc88:0dbdd229c5daddb38ea798307470e3ef46313a126d4a6d91fb12e1c776b9727db328798b0965b5cba110fba3f46d9b22

export WEBSERVER_DBHOST=db.team1.gti778.ets.bimweb.net
export WEBSERVER_DBPORT=3360
export WEBSERVER_DBUSER=gti778
export WEBSERVER_DBPASS="gti778psw"  # Remplace par le bon mot de passe


nohup java -jar "$JAR_FILE" &
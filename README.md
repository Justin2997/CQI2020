# CQI2020

Comment utiliser le projet R

1-Télécharger R studio

2-Pour entrainer, ouvrirmake_model et  perser sur source. (S'assurer d'avoir les 
fichier de la compétition dans le dossier)

3-Pour prédir, ouvrir predict.R et le sourcer (S'assurer d'avoir le fichier de compétition For_Evaluation.csv
ainsi que CSI_2.model dans le dossier du projet)


# How to start the bd
You need to have docker running :
```
docker run -d --name postgres -v postgres_db:/var/lib/postgresql/data -p 5432:5432 postgres:11
```

# How to run backend

You have to add the correct envrionnement variable :
```
BACKEND_PORT="8000"
DATABASE_HOST="localhost"
DATABASE_NAME="hpot"
DATABASE_USERNAME="postgres"
DATABASE_PASSWORD=""
```
You can start
```
bundle exec rails s -p ${BACKEND_PORT} -b '0.0.0.0'
```

# How to run frontend

You have to add the 

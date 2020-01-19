# How to run

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


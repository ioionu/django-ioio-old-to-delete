#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."
    while ! nc -z $DATABASE_HOST $DATABASE_PORT; do
        sleep 1
        echo "${DATABASE_HOST}:${DATABASE_PORT}"
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py migrate

exec "$@"

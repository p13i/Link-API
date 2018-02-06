web: cd api; python manage.py migrate; python manage.py collectstatic --noinput; gunicorn --pythonpath api api.wsgi --log-file -

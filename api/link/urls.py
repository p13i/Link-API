from django.conf.urls import url, include
from rest_framework_nested import routers
from . import views

urlpatterns = [
    url(r'^link/create/', views.create_link),
    url(r'^link/list/', views.get_links),
    url(r'^link/resolve/(?P<short_url_id>[a-z]+)/', views.resolve_link),
]

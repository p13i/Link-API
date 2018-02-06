from django.db import models


class Link(models.Model):
    long_url = models.URLField(null=False, blank=False)
    short_url_id = models.URLField(null=False, blank=False, unique=True)

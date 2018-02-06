from rest_framework.viewsets import ModelViewSet
from rest_framework.decorators import api_view
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from .serializers import LinkSerializer
from .models import Link
import random
import string


@api_view(['POST'])
def create_link(request):
    long_url = request.data['long_url']
    short_url_id = ''.join(random.sample(string.ascii_lowercase, 3))

    link = Link.objects.create(
        long_url=long_url,
        short_url_id=short_url_id,
    )

    return Response(LinkSerializer(link).data)


@api_view(['GET'])
def get_links(request):
    return Response(LinkSerializer(Link.objects.all(), many=True).data)


@api_view(['GET'])
def resolve_link(request, short_url_id):
    link = Link.objects.get(
        short_url_id=short_url_id,
    )
    return Response(LinkSerializer(link).data)

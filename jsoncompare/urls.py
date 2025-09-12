from django.urls import path
from . import views

urlpatterns = [
    path('json-compare/', views.json_compare_page, name='json_compare'),
    path('json-formatter/', views.json_formatter_page, name='json_formatter'),
    path('json-validator/', views.json_validator_page, name='json_validator'),
    path('api/compare-json/', views.compare_json_api, name='compare_json_api'),
]
import requests


def lambda_handler(event, context):
    message = 'Hello from lambda'  
    return { 
        'message' : message
    }
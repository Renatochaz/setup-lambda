import sys
import json
import boto3


client = boto3.client('ecr')


def get_images(name: str) -> dict:
    response = client.list_images(repositoryName=name)
    return response["imageIds"]

def verify_image_tag():
    input_dict = json.loads(sys.stdin.read())
    output_dict = {
        'image_tag_exists': 'false'
    }

    ecr_name = input_dict.get('ecr_name')
    image_tag = input_dict.get('image_tag')
    try:
        images = get_images(ecr_name)
        for img in images:
            if image_tag == img["imageTag"]:
                output_dict["image_tag_exists"] = 'true'

    except client.exceptions.RepositoryNotFoundException:
        output_dict["image_tag_exists"] = 'false'


    output = json.dumps(output_dict)
    sys.stdout.write(output)


if __name__=='__main__':
    verify_image_tag()

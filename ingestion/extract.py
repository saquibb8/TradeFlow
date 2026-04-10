import requests
import os
from datetime import date, timedelta
import json
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import boto3
from dotenv import load_dotenv


load_dotenv()



def save_entities(all_items, entity_name, s3):

    bucket = os.getenv("S3_BUCKET_NAME")

    dateAsPath = date.today().strftime("%Y/%m/%d")

    to_save_path = f"raw/{entity_name}/" + dateAsPath

    file_path = to_save_path + f"/{entity_name}.json"

    final_data = {
        entity_name : all_items,
        "total" : len(all_items),
        "extracted_at" : date.today().isoformat()
    }

    print("writing to s3")

    s3.put_object(
        Bucket=bucket,
        Key=file_path,
        Body=json.dumps(final_data, indent=2).encode("utf-8")
    )

def get_api_response(session, api_endpoint):
    try:
        response = session.get(api_endpoint, timeout=30)
        response.raise_for_status()
        return response
    except:
        return None

def extract_entity(entity_name, entity_endpoint):

    finishedExtraction = False
    skip = 0
    all_items = []
    session = requests.Session()
    retry = Retry(total=3, backoff_factor=1, status_forcelist=[500, 502, 503, 504])
    session.mount("https://", HTTPAdapter(max_retries=retry))

    aws_profile = os.getenv("AWS_PROFILE")
    aws_region = os.getenv("AWS_REGION")

    boto3_session = boto3.Session(profile_name=aws_profile)
    s3 = boto3_session.client("s3", region_name=aws_region)


    while(not finishedExtraction):

        endpoint_extension = f"limit=30&skip={skip}"

        response = get_api_response(session, entity_endpoint+endpoint_extension)

        if not response:
            raise Exception(f"Couldnt process {entity_name}, faced some error fetching the API response")

        json_response = response.json()

        if not json_response[entity_name]:
            finishedExtraction = True
            break

        all_items.extend(json_response[entity_name])

        skip += 30
    
    numItems = len(all_items)

    save_entities(all_items, entity_name, s3)

    print(f"Num of {entity_name} extracted", numItems)

if __name__ == "__main__":

    entities = ["products", "users", "carts"]
    for entity_name in entities:
        entity_endpoint = f"https://dummyjson.com/{entity_name}?"
        extract_entity(entity_name, entity_endpoint)



    

    


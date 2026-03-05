import json
import time
import random

def lambda_handler(event, context):
    """
    A healthy Lambda function that processes requests successfully.
    """
    
    # Simulate some processing
    processing_time = random.uniform(0.1, 0.5)
    time.sleep(processing_time)
    
    response_data = {
        'status': 'success',
        'message': 'Request processed successfully',
        'processing_time_ms': round(processing_time * 1000, 2),
        'timestamp': int(time.time())
    }
    
    print(f"Successfully processed request in {processing_time:.2f}s")
    
    return {
        'statusCode': 200,
        'body': json.dumps(response_data),
        'headers': {
            'Content-Type': 'application/json'
        }
    }

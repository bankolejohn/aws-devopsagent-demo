import json
import time
import random

def lambda_handler(event, context):
    """
    A faulty Lambda function that demonstrates various failure scenarios.
    This simulates real-world incidents for DevOps monitoring.
    """
    
    # Random failure scenarios
    failure_type = random.choice(['timeout', 'error', 'memory', 'success'])
    
    if failure_type == 'timeout':
        # Simulate timeout scenario
        print("WARNING: Simulating slow response")
        time.sleep(25)  # Close to Lambda timeout
        
    elif failure_type == 'error':
        # Simulate application error
        print("ERROR: Simulating application failure")
        raise Exception("Database connection failed - simulated error")
        
    elif failure_type == 'memory':
        # Simulate memory issue
        print("WARNING: Simulating memory pressure")
        large_data = ['x' * 1000000 for _ in range(100)]
        time.sleep(2)
        
    else:
        # Occasionally succeed (20% of the time)
        print("INFO: Request succeeded")
        return {
            'statusCode': 200,
            'body': json.dumps({
                'status': 'success',
                'message': 'Rare success case'
            })
        }
    
    return {
        'statusCode': 500,
        'body': json.dumps({
            'status': 'error',
            'message': f'Failed with {failure_type}'
        })
    }

from typing import Set
import boto3
import os
import json
import sys
from time import sleep
session = boto3.Session(profile_name='development')
east = 'us-east-1'
west = 'us-west-2'
dynamo_client = boto3.client('dynamodb',region_name=east)
dynamo = boto3.resource("dynamodb",region_name=east)
route53 = boto3.client("route53")
# failover_from =os.environ["Failover_from"]
# failover_to =os.environ["Failover_to"]
# Dynamo =os.environ["DynamoTableName"]
# response = dynamo_client.describe_table(
#     TableName='dr_failover'
# )
# print(response)
#Name='disaster-recovery.pirmatovv.com'
#Record='disastryrecoverywest-env.eba-saxez2mp.us-west-2.elasticbeanstalk.com.'
#weight=0
Dynamo='dr_failover'
#SetID=str(3)
#hostedzoneid='Z38NKT9BP95V3O' # west eb hosted zone id by aws in west
#hostedzoneid='Z117KPS5GTRQ2G' # east eb hosted zone id by aws in ease
failover_from = 'East'
failover_to = 'West'
def update_dynamo(Name, Record, weight, Dynamo):
    try:
        resp = dynamo_client.update_item(TableName=Dynamo, Key={'Name': {'S': Name}, 'Records': {'S': Record}}, AttributeUpdates={'Weight':{'Value':{'N': str(weight)}}})
        print("Dynamo Updated with: " + Name + " " + Record + " " + str(weight))
    except Exception as error:
        print(error)
#update_dynamo(Name, Record, weight, Dynamo)
def update_route53_aliastarget(Name,SetID,weight,Record,hostedzoneid, TTL):
    try: 
        response = route53.change_resource_record_sets(
            HostedZoneId='Z077091817KZHK8SKIM86', #your own hosted zone id
            ChangeBatch={
                'Comment': 'DR event for SprintQA DevOps team apps from east to west.',
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': Name,
                            'Type': 'A',
                            'SetIdentifier': SetID,
                            'Weight': weight,
                            'AliasTarget': {
                                'HostedZoneId': hostedzoneid, #aws elasticbeanstalk hosted zone id, maintained by aws 
                                'DNSName': Record,
                                'EvaluateTargetHealth': True
                            }
                        }
                    }
                ]
            }
        )
    except Exception as error:
        print(error)
#update_route53_aliastarget(Name,SetID,weight,Record,hostedzoneid)
def main():
    table = dynamo.Table(Dynamo) #line 26 var name
    scan_response = table.scan(AttributesToGet=["Records","Name","Weight","Type","SetIdentifier","TTL"])
    #print(scan_response)
    for i in scan_response["Items"]:
        Weight = i["Weight"] # Weight from the table
        Type = i["Type"]
        SetID = i["SetIdentifier"]
        TTL = int(i["TTL"])
        Record = i["Records"]
        Name = i["Name"]
        print(Weight)
        print(Type)
        print(SetID)
        print(TTL)
        print(Record)
        print(Name)
        if SetID=='2':
            region_name='west'
        elif SetID=='3':
            region_name='east'
        if failover_to=='West' and failover_from=='East':
            print('failing over from East to West')
            if region_name=='east':
                if Type == "ALIAS":
                    weight = 0 # weight from the Route53 record set 
                    hostedzoneid = "Z117KPS5GTRQ2G" #ElasticBeanstalk us-east-1 Route53 hosted zone ID
                    print("Calling Update ALIAS function")
                    print(Name)
                    update_route53_aliastarget(Name, weight, hostedzoneid, TTL, SetID, Record)
                else:
                    print('Error')
            elif region_name=='west':
                if Type == "ALIAS":
                    weight = 1 # weight from the Route53 record set 
                    hostedzoneid = "Z38NKT9BP95V3O" #ElasticBeanstalk us-west-2 Route53 hosted zone ID
                    print("Calling Update ALIAS function")
                    print(Name)
                    update_route53_aliastarget(Name, weight, hostedzoneid, TTL, SetID, Record)
                else:
                    print('Error')
        elif failover_from=='West' and failover_to=='East':
            print('failing over from West to East')
main()
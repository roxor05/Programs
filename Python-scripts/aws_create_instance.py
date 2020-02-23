import boto3
######################################################################################
            # Inputs
######################################################################################
AMI_ID = input("AMI ID: ")
print(AMI_ID)

Instance_Type = input("Instance type: ") 
print(Instance_Type)

Volume_Size = input("Volume Size: ")
print(Volume_Size)

SecurityGroupIds = input("Security group ID: ")
print(SecurityGroupIds)

Subnet_Id = input("Subnet ID: ")
print(Subnet_Id)

###################################################################################
            # program
###################################################################################
client = boto3.client('ec2', region_name='us-west-2')
response = client.request_spot_instances(
    # AvailabilityZoneGroup='string',
    # BlockDurationMinutes=123,
    # ClientToken='string',
    # DryRun=True|False,
    InstanceCount=1,
    # LaunchGroup='string',
    LaunchSpecification={
        'SecurityGroupIds': [
            'string'
        ],
        'BlockDeviceMappings': [
            {
                'DeviceName': '/dev/sda1',
                'Ebs': {
                    'DeleteOnTermination': True,
                    'VolumeSize': 123,
                    'VolumeType': 'gp2',
                },
            },
        ],
        'ImageId': 'string',
        'InstanceType':  , 
        'KernelId': 'string',
        'KeyName': 'string',
        'Monitoring': {
            'Enabled': True|False
        },
        'NetworkInterfaces': [
            {
                'SubnetId': 'string'
            },
        ],
        'SubnetId': 'string'
    },
    SpotPrice='string',
    Type='one-time'|'persistent',
    ValidFrom=datetime(2015, 1, 1),
    ValidUntil=datetime(2015, 1, 1),
    InstanceInterruptionBehavior='hibernate'|'stop'|'terminate'
)


###################################################################################
# On demand instance
###################################################################################
# response = client.run_instances(
#     BlockDeviceMappings=[
#         {
#             'DeviceName': '/dev/sda1',
#             'Ebs': {

#                 'DeleteOnTermination': True,
#                 'VolumeSize': 50,
#                 'VolumeType': 'gp2'
#             },
#         },
#         {            
#             'DeviceName': '/dev/sdf',
#             'Ebs': {

#                 'DeleteOnTermination': True,
#                 'VolumeSize': 100,
#                 'VolumeType': 'gp2'
#             },
#         },
#     ],
#     ImageId='ami-6cd6f714',
#     InstanceType='t2.micro',
#     MaxCount=1,
#     MinCount=1,
#     Monitoring={
#         'Enabled': False
#     },
#     SecurityGroupIds=[
#         'sg-1f39854x',
#     ],
#     SubnetId='string'
# )
########################################################################################################


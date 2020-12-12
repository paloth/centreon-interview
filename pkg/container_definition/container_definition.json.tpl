[
  {
    "name": "nginx-portal",
    "image": "${app_image}",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "${awslogs-group}",
          "awslogs-region": "eu-west-1",
          "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ]
  }
]

{
  "executionRoleArn": "arn:aws:iam::791927302548:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "dnsSearchDomains": null,
      "environmentFiles": null,
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "/ecs/jenkins",
          "awslogs-region": "eu-west-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "hostPort": 8080,
          "protocol": "tcp",
          "containerPort": 8080
        },
        {
          "hostPort": 50000,
          "protocol": "tcp",
          "containerPort": 50000
        }
      ],
      "environment": [
        {
          "name": "DOCKER_CERT_PATH",
          "value": "/certs/client"
        },
        {
          "name": "DOCKER_HOST",
          "value": "tcp://docker:2376"
        },
        {
          "name": "DOCKER_TLS_VERIFY",
          "value": "1"
        }
      ],
      "mountPoints": [
        {
          "readOnly": null,
          "containerPath": "\\certs\\client",
          "sourceVolume": "jenkins"
        },
        {
          "readOnly": null,
          "containerPath": "\\var\\jenkins_home",
          "sourceVolume": "jenkins"
        }
      ],
      "image": "jenkins/jenkins:slim",
      "name": "jenkins"
    }
  ],
  "memory": "2048",
  "taskRoleArn": "arn:aws:iam::791927302548:role/ecs-admin",
  "compatibilities": [
    "EC2",
    "FARGATE"
  ],
  "family": "jenkins",
  "requiresCompatibilities": [
    "FARGATE"
  ],
  "networkMode": "awsvpc",
  "cpu": "1024",
  "volumes": [
    {
      "efsVolumeConfiguration": {
        "fileSystemId": "fs-36a9fcfc",
        "authorizationConfig": {
          "iam": "ENABLED"
        },
        "transitEncryption": "ENABLED",
        "rootDirectory": "/"
      },
      "name": "jenkins",
      "host": null,
      "dockerVolumeConfiguration": null
    }
  ]
}

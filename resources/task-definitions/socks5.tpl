[
    {
        "cpu": 0,
        "environment": [
            {
                "name": "PROXY_SERVER",
                "value": "0.0.0.0:1080"
            }
        ],
        "essential": true,
        "image": "docker.io/xkuma/socks5",
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/socks5",
                "awslogs-region": "ap-southeast-2",
                "awslogs-stream-prefix": "ecs"
            }
        },
        "mountPoints": [],
        "name": "socks5",
        "portMappings": [
            {
                "containerPort": 1080,
                "hostPort": 1080,
                "protocol": "tcp"
            }
        ],
        "volumesFrom": []
        }
]

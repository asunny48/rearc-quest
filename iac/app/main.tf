
provider "aws" {
  region = var.region
}

data "terraform_remote_state" "infra" {
  backend = "local"

  config = {
    path = "../infra/terraform.tfstate"
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "ecs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "008971679622.dkr.ecr.us-east-2.amazonaws.com/sunnyrearc@sha256:${var.image_hash}"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "SECRET_WORD"
          value = var.secret_word
        }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "app" {
  name            = "ecs-service"
  cluster         = data.terraform_remote_state.infra.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.terraform_remote_state.infra.outputs.private_subnets
    security_groups  = [data.terraform_remote_state.infra.outputs.ecs_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.infra.outputs.target_group_arn
    container_name   = "app"
    container_port   = 3000
  }

  depends_on = [
    data.terraform_remote_state.infra
  ]
}


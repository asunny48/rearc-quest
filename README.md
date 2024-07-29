# rearc-quest

This project demonstrates how to deploy a containerized Node.js web service using Terraform on Amazon Elastic Container Service (Amazon ECS). 
The project utilizes AWS Fargate for serverless compute, making the sample web service publicly available through an Application Load Balancer (ALB).

-----------------------------------------------------------------------------

The deployed application can be accessed at: https://app-lb-1516613361.us-east-2.elb.amazonaws.com/

-----------------------------------------------------------------------

![image](https://github.com/user-attachments/assets/300fbbaa-4a97-4ae1-b547-97704ded22ed)

# Project Structure

- `/iac` contains the infrastructure as code (IaC) Terraform files.
- `/src` contains the application source code.
- `/bin` contains backend script files.
- `/test` contains the package.json for the application.

---------------------------------------------

# Prerequisites

Before you begin, ensure you have the following prerequisites:

**AWS Account**: An AWS account with necessary permissions to create resources.

**AWS CLI**: Installed and configured with your AWS access keys.

**Domain Name:** A purchased domain name set up in Route 53.

**ACM Certificate:** A public certificate requested for your domain from ACM.

**NPM:** Node.js package manager for managing dependencies.

**Docker:** For containerizing the application.

**Terraform:** For infrastructure as code.

-------------------------------------------------------

# **Usage with Docker**


docker build -t quest:latest .

docker run -p 3000:3000 quest:latest

-----------------------------------------------

-----------------------------------------

# **Deploy to public cloud**

Instead of deploying this simple demonstration application directly on a virtual server, I opted for a more robust cloud-based approach. 
Direct deployment on a virtual server is rarely used for well-designed cloud applications. Thus, for this exercise, I decided to bypass this traditional deployment method.

-------------------------------

--------------------------

# **Deploy the app in a Docker container**



I used a Dockerfile to compile the quest application, then ran it locally and accessed it via curl to validate this Docker application.

I then deployed it via Terraform to ECS (Manual creation of resources followed by "codifying" for me has been an anti-pattern). 
Terraform deploys all resources except for:

The Docker image, created and deployed to ECR via the make all command.

DNS entry, manually created on Route 53.

TLS certificates, obtained from AWS ACM.

---------------------------------------------------------

# Improvements:


This exercise serves as a Proof of Concept, focusing on quickly demonstrating functionality before a full-scale implementation to make the solution production-ready.
As such, it has similar limitations.

Due to time constraints, there are several enhancements that I did not include which would complete this basic application:

Implement a CI/CD pipeline with GitHub Actions or a similar tool to fully automate the solution.

Establish multiple deployment environments (e.g., development, QA/staging, production).

Implement semantic versioning.

Set up logging and monitoring.

Use a secure storage mechanism for TLS credentials and the "Secret Word."

Add code and image scanning.

Restrict access to the repository and enforce pull requests and approvals.

--------------------------------------

# Contributing


To contribute to this project, follow the steps below:

****Fork this repository****

**Create a new branch (git checkout -b feature/branch-name)**

**Make your changes**

**Commit your changes (git commit -am 'Add some feature')**

**Push to the branch (git push origin feature/branch-name)**

**Create a new Pull Request**


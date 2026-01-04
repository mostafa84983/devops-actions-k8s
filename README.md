## 🚀 Getting Started

# DevOps Kubernetes Deployment with GitHub Actions

This repository demonstrates a complete CI/CD pipeline using GitHub Actions to containerize a Python Weather App, push it to Amazon ECR, and deploy it to a Kubernetes cluster running on AWS EC2 (k3s).

## Repository Structure
```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Actions CI/CD pipeline
├── app/
│   ├── app.py                 # Main Python application (Flask/Weather API)
│   ├── requirements.txt       # Python dependencies
│   ├── Dockerfile             # Container definition
│   └── templates/             # HTML templates
├── k8s/
│   ├── deployment.yaml        # Kubernetes Deployment manifest
│   ├── service.yaml           # Kubernetes Service manifest
│   └── namespace.yaml         # Kubernetes Namespace manifest
├── terraform/                 # Infrastructure as Code for AWS
└── README.md                  # Project documentation
```

## Prerequisites

* An **AWS Account** with permissions to manage VPC, EC2, and ECR.
* **OpenWeatherMap** account for an API key.
* **Terraform** installed (to provision the infrastructure).
* **Docker** "optional" installed locally (for local container testing).
* **Python 3.x** "optional" installed locally (for local app testing).

## Setup Instructions

### 1. Clone the Repository

```bash
git clone [https://github.com/mostafa84983/devops-actions-k8s.git](https://github.com/mostafa84983/devops-actions-k8s.git)
cd devops-actions-k8s
```

### 2. Provision Infrastructure with Terraform

Navigate to the terraform directory to create your VPC, ECR, and EC2 instances running k3s:

```bash
cd terraform
terraform init
terraform apply -auto-approve
cd ..
```

### 3. Configure the Weather API

The application uses OpenWeatherMap. While a default key is present in `app/app.py`, it is recommended to use your own:

* Open `app/app.py`.
* Update the `API_KEY` variable or ensure your environment variable is set:

```python
API_KEY = os.environ.get("API_KEY") or "YOUR_ACTUAL_API_KEY_HERE"
```

### 4. Configure Amazon ECR

* Get your ECR Repository URI from the Terraform output or the AWS Console.
* Open `.github/workflows/deploy.yml`.
* Replace the image URL placeholders with your specific ECR Repository URI (e.g., `1234567890.dkr.ecr.us-east-1.amazonaws.com/my-repo`).

### 5. Configure Kubernetes Credentials

* Ensure your GitHub Secrets contain the necessary AWS credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
* In `.github/workflows/deploy.yml`, verify the cluster connection steps point to your EC2 instance's IP or the cluster endpoint provided by the Terraform output.

### 6. Trigger the Workflow

Push your changes to the main branch:

```bash
git add .
git commit -m "Configure deployment settings"
git push origin main
```

---

## 💻 Running Locally

### Option A: Local Python Execution (Direct)

1. **Navigate to app directory:**

```bash
cd app
```

2. **Install Dependencies:**

```bash
pip install -r requirements.txt
```

3. **Set API Key (Optional):**

```bash
export API_KEY="your_api_key_here"
```

4. **Run the App:**

```bash
python app.py
```

### Option B: Local Containerized Execution (Docker)

1. **Build the Image:**

```bash
docker build -t weather-app-local ./app
```

2. **Run the Container:**

```bash
docker run -p 5000:5000 -e API_KEY="your_api_key_here" weather-app-local
```

---

### Option C: Local Kubernetes Cluster

1. **Apply the manifests:**

```bash
kubectl apply -f k8s/
```

2. **Verify the deployment:**

```bash
kubectl get pods -n <your-namespace>
kubectl get services -n <your-namespace>
```

## Deployment Manifests

* **k8s/deployment.yaml**: Defines the desired state of the application (replicas, image name).
* **k8s/service.yaml**: Exposes the application to the network.
* **k8s/namespace.yaml**: Defines the isolated environment for the resources.

## Video Resources

```

[How to Deploy Python App to Kubernetes](https://www.youtube.com/watch?v=TMbXwNtuAJo)

This video provides a practical walkthrough of setting up a DevOps pipeline with GitHub Actions and deploying a containerized application to Kubernetes, which aligns with the steps required for this repository.

```

```

[Level-up Your DevOps with GitHub Actions and Kubernetes](https://www.youtube.com/watch?v=L-Q9OpKiOyY)

This video provides a deep dive into building a DevOps pipeline from scratch, specifically covering how to integrate Docker and GitHub Actions for Kubernetes deployments, which mirrors the architecture of this repository.

```

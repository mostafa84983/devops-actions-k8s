# Flask-K8s-Demo

This is a demo project showcasing the deployment of a Flask app on a Kubernetes cluster using GitHub Actions.

## Features

*   Simple Flask app that displays the weather for a given city
*   Uses OpenWeatherMap API to fetch weather data
*   Deploys app on a Kubernetes cluster using GitHub Actions
*   Uses Amazon ECR as a container registry

## How to use

1.  Clone the repository
2.  Create an OpenWeatherMap API key and add it to the `app.py` file
3.  Create an Amazon ECR repository and add the URL to the `deploy.yml` file
4.  Create a Kubernetes cluster and add the credentials to the `deploy.yml` file
5.  Push changes to the repository to trigger the GitHub Actions workflow

## Technologies used

*   Flask
*   Kubernetes
*   GitHub Actions
*   Amazon ECR
*   OpenWeatherMap API

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

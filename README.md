# Flask-K8s-Demo

This is a demo project showcasing the deployment of a Flask app on a Kubernetes cluster using GitHub Actions.

## Features

* Simple Flask app that displays the weather for a given city
* Uses OpenWeatherMap API to fetch weather data
* Deploys app on a Kubernetes cluster using GitHub Actions
* Uses Amazon ECR as a container registry

## Running Locally

To run the application on your local machine for development or testing:

1.  **Clone the repository**
    ```bash
    git clone <repository-url>
    cd Flask-K8s-Demo
    ```

2.  **Install dependencies**
    Ensure you have Python installed, then install the required packages:
    ```bash
    pip install -r requirements.txt
    ```

3.  **Run the application**
    Execute the Python script to start the server:
    ```bash
    python app.py
    ```

    *Note: The application will automatically check for an `API_KEY` environment variable. If one is not found, it defaults to the hardcoded key provided in the source code.*

## Deployment Workflow

To deploy this application to a Kubernetes cluster:

1.  **Clone the repository** (if you haven't already).
2.  **Configure the API Key**:
    * The app uses the following logic: `API_KEY = os.environ.get("API_KEY")`.
    * Ensure your Kubernetes deployment passes this secret, or it will fall back to the default key.
3.  **Configure Container Registry**:
    * Create an Amazon ECR repository.
    * Add the repository URL to the `deploy.yml` file.
4.  **Configure Kubernetes**:
    * Create a Kubernetes cluster.
    * Add the necessary credentials (e.g., `KUBE_CONFIG`) to your GitHub repository secrets.
5.  **Trigger Deployment**:
    * Push changes to the repository to trigger the GitHub Actions workflow defined in `deploy.yml`.

## Technologies used

* Flask
* Kubernetes
* GitHub Actions
* Amazon ECR
* OpenWeatherMap API

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

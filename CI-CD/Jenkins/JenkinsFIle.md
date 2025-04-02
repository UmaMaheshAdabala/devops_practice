### **Introduction to Jenkinsfile**

A **Jenkinsfile** is a script that defines the entire CI/CD pipeline for your project in **Jenkins**. It is written using **Groovy-based DSL (Domain-Specific Language)** and can be stored in your GitHub repository.

Since you are working with a **Spring Boot application**, using **GitHub, SonarQube, Docker, and ArgoCD**, I will guide you from **basic to advanced Jenkinsfile concepts** in an **industrial-standard format**.

---

## **🔹 Step 1: Writing a Basic Jenkinsfile**

This basic pipeline will:

1. Clone the **GitHub repository**.
2. Build the **Spring Boot application**.
3. Run **unit tests**.

### **Basic Jenkinsfile (Declarative Pipeline)**

```groovy
pipeline {
    agent any  // Runs on any available agent

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build Application') {
            steps {
                sh './mvnw clean package'  // Builds the Spring Boot app
            }
        }

        stage('Run Tests') {
            steps {
                sh './mvnw test'  // Runs unit tests
            }
        }
    }
}
```

🔹 **Explanation:**

- **`agent any`** → Runs the pipeline on any available Jenkins agent.
- **`git`** → Clones the repository from GitHub.
- **`sh './mvnw clean package'`** → Builds the Spring Boot application using Maven.
- **`sh './mvnw test'`** → Runs unit tests.

---

## **🔹 Step 2: Adding SonarQube Code Analysis**

SonarQube ensures **code quality and security analysis**.

### **Jenkinsfile with SonarQube Integration**

```groovy
pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://your-sonarqube-server:9000'  // SonarQube URL
        SONARQUBE_TOKEN = credentials('sonar-token')  // Use Jenkins credential ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build Application') {
            steps {
                sh './mvnw clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh './mvnw test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh './mvnw sonar:sonar -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_TOKEN'
                }
            }
        }
    }
}
```

🔹 **Additional Concepts:**

- **`environment` block** → Defines environment variables.
- **`credentials('sonar-token')`** → Fetches SonarQube authentication token from Jenkins credentials.
- **`withSonarQubeEnv('SonarQube')`** → Integrates SonarQube.

---

## **🔹 Step 3: Dockerizing the Application**

Now, we build a **Docker image** and push it to **Docker Hub**.

### **Jenkinsfile with Docker Integration**

```groovy
pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://your-sonarqube-server:9000'
        SONARQUBE_TOKEN = credentials('sonar-token')
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub')
        IMAGE_NAME = 'your-docker-hub-username/springboot-app'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build Application') {
            steps {
                sh './mvnw clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh './mvnw test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh './mvnw sonar:sonar -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_TOKEN'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }
    }
}
```

🔹 **New Concepts:**

- **`docker build -t $IMAGE_NAME .`** → Builds a Docker image.
- **`docker push $IMAGE_NAME`** → Pushes the image to Docker Hub.
- **`withDockerRegistry`** → Logs into Docker Hub before pushing the image.

---

## **🔹 Step 4: Deploying to Kubernetes using ArgoCD**

Now, we will deploy our **Docker container to Kubernetes** using **ArgoCD**.

### **Jenkinsfile with ArgoCD Deployment**

```groovy
pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://your-sonarqube-server:9000'
        SONARQUBE_TOKEN = credentials('sonar-token')
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub')
        IMAGE_NAME = 'your-docker-hub-username/springboot-app'
        ARGOCD_SERVER = 'argocd.yourdomain.com'
        ARGOCD_AUTH_TOKEN = credentials('argocd-token')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build Application') {
            steps {
                sh './mvnw clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh './mvnw test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh './mvnw sonar:sonar -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_TOKEN'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Deploy with ArgoCD') {
            steps {
                sh """
                    curl -k -X POST https://$ARGOCD_SERVER/api/v1/applications -H "Authorization: Bearer $ARGOCD_AUTH_TOKEN" \
                    -H "Content-Type: application/json" \
                    -d '{
                        "metadata": {
                            "name": "springboot-app"
                        },
                        "spec": {
                            "destination": {
                                "server": "https://kubernetes.default.svc",
                                "namespace": "default"
                            },
                            "source": {
                                "repoURL": "https://github.com/your-repo.git",
                                "path": "k8s-manifests",
                                "targetRevision": "main"
                            },
                            "syncPolicy": {
                                "automated": {}
                            }
                        }
                    }'
                """
            }
        }
    }
}
```

🔹 **New Concepts:**

- **ArgoCD API request** to trigger deployment.
- Uses **ArgoCD authentication token** stored in Jenkins credentials.

---

## **🎯 Summary**

1. **Basic Pipeline** → Clones code, builds Spring Boot app, and runs tests.
2. **SonarQube Integration** → Adds code quality analysis.
3. **Docker Integration** → Builds and pushes Docker images.
4. **ArgoCD Deployment** → Deploys the container to Kubernetes using ArgoCD.

Would you like a breakdown of any stage, or need help setting up Jenkins? 🚀

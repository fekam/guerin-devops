pipeline {
    agent any

    stages {
        stage('Cloner le dépôt') {
            steps {
                 git branch: 'main', url: 'https://github.com/fekam/guerin-devops.git'
            }
        }
        stage('Construire l\'image Docker') {
            steps {
                sh 'docker build -t mon-utilisateur/my-web-app .'   
            }
        }
        stage('Pousser l\'image Docker') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_HUB_PASSWORD')]) {
                    sh 'echo $DOCKER_HUB_PASSWORD | docker login -u mon-utilisateur --password-stdin'
                    sh 'docker push mon-utilisateur/my-web-app'
                }
            }
        }
        stage('Déployer avec Ansible') {
            steps {
                sh 'ansible-playbook playbook.yml'
            }
        }
    }
}

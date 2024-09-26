pipeline {
    agent any

    stages {
        stage('Cloner le dépôt') {
            steps {
                 git branch: 'main', url: 'https://github.com/fekam/guerin-devops.git'
            }
        }

        stage('Déployer avec Ansible') {
            steps {
                sh 'ansible-playbook playbook.yml'
            }
        }
    }
}

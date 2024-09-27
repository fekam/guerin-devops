pipeline {
    agent any

    stages {
        stage('Cloner le dépôt') {
            steps {
                 sh '''
                    sudo ssh -i /root/.ssh/id_ed25519 guerin@192.168.2.42 'git branch: 'main', url: 'https://github.com/fekam/guerin-devops.git' /opt/'
                '''
            }
        }

        stage('Déployer avec Ansible') {
            steps {
                sh 'ansible-playbook playbook.yml'
            }
        }
    }
}

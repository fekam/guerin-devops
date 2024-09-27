pipeline {
    agent any

    stages {
        stage('Cloner le dépôt') {
            steps {
                 sh '''
                    sudo ssh -i /root/.ssh/id_ed25519 guerin@192.168.2.42 'sudo rm -rf /opt/guerinapp/* && git clone -b main https://github.com/fekam/guerin-devops.git /opt/guerinapp'
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

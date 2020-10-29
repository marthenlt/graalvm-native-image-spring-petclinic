node {
    def app

    stage('Checkout the source code') {
        checkout scm
    }

    stage('Maven build') {
        sh './mvnw package -DskipTests'
    }

    stage('Build & push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app = docker.build("marthenl/petclinic-mysql-native-image:0.9", "-f Dockerfile-multistage .")
            app.push()
        }
    }

}

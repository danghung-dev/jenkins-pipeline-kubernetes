podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'kubectl', image: 'roffe/kubectl', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'awscli', image: 'atlassian/pipelines-awscli', command: 'cat', ttyEnabled: true),
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]) {
    node('mypod') {
      echo 'Getting source code...'
		  checkout scm
      stage('test docker') {
        container('awscli') {
          DOCKER_LOGIN = sh (
            script: 'aws ecr get-login --no-include-email --region ap-southeast-1',
            returnStdout: true
          ).trim()
          
        }
        echo "docker: ${DOCKER_LOGIN}"
        container('docker') {
          REGISTRY_URL="744004065806.dkr.ecr.ap-southeast-1.amazonaws.com/dev-bidding-service"
          sh """
          ls -la
          docker build --network=host -t ${REGISTRY_URL}:vtest --pull=true .
          docker tag ${REGISTRY_URL}:vtest ${REGISTRY_URL}:latest
          ${DOCKER_LOGIN}
          docker push ${REGISTRY_URL}:vtest
          """
        }
      }
      stage('test kubectl') {
        container('kubectl') {
          // sh "ls -la"
          sh "kubectl apply -f deploy.yml"
        }
      }
      stage('clean') {
        deleteDir()
      }
    }
  }

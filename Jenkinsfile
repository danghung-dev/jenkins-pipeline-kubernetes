podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'kubectl', image: 'roffe/kubectl', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'awscli', image: 'atlassian/pipelines-awscli', command: 'cat', ttyEnabled: true),
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]) {
    node('mypod') {
      stage('test docker') {
        container('awscli') {
          DOCKER_LOGIN = sh (
            script: 'aws ecr get-login --no-include-email --region ap-southeast-1',
            returnStdout: true
          ).trim()
          
        }
        echo "docker: ${DOCKER_LOGIN}"
        container('docker') {
          sh "docker ps"
          sh "${DOCKER_LOGIN}"
        }
      }
      stage('test kubectl') {
        container('kubectl') {
          sh "kubectl get pods"
        }
      }
      stage('clean') {
        deleteDir()
      }
    }
  }

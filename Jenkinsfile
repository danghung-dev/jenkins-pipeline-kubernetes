podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'kubectl', image: 'roffe/kubectl', command: 'cat', ttyEnabled: true),
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]) {
    node('mypod') {
      stage('test docker') {
        container('docker') {
          sh "docker ps"
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

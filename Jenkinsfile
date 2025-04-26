pipeline {
  agent any

    environment {
    FLUTTER_VERSION = '3.22.0'
        FLUTTER_HOME = "${env.WORKSPACE}/flutter"
        PATH = "${env.FLUTTER_HOME}/bin:${env.PATH}"
    }

    stages {
    stage('Clonar Projeto') {
      steps {
        git url: 'https://github.com/Luiz1717/imcapp.git',
                    branch: 'main'
            }
        }

        stage('Instalar Flutter') {
      steps {
        script {
          if (!fileExists("${env.FLUTTER_HOME}/bin/flutter")) {
            sh """
                            git clone https://github.com/flutter/flutter.git --branch ${FLUTTER_VERSION} ${env.FLUTTER_HOME}
                            flutter precache
                        """
                    }
                    sh 'flutter --version'
                    sh 'flutter doctor'
                }
            }
        }

        stage('Preparar Dependências') {
      steps {
        sh '''
                    flutter pub get
                    flutter pub upgrade
                '''
            }
        }

        stage('Rodar Testes') {
      steps {
        sh '''
                    flutter analyze
                    flutter test integration_test/
                '''
            }
        }

        stage('Build APK') {
      steps {
        sh 'flutter build apk --release'
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
            }
        }
    }

    post {
    always {
      cleanWs()
            echo 'Pipeline finalizada.'
        }
        success {
      echo '🎉 Build e Testes passaram com sucesso!'

        }
        failure {
      echo '❌ Falha no pipeline.'

        }
    }
}
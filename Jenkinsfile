
pipeline {
  agent any

    environment {
    FLUTTER_VERSION = '3.22.0' // ou ajuste se necessário
    }

    stages {
    stage('Clonar Projeto') {
      steps {
        git 'https://github.com/Luiz1717/imcapp.git'
            }
        }

        stage('Instalar Flutter') {
      steps {
        sh '''
                    git clone https://github.com/flutter/flutter.git --branch stable
                    export PATH="$PATH:`pwd`/flutter/bin"
                    flutter --version
                '''
            }
        }

        stage('Preparar Dependências') {
      steps {
        sh '''
                    export PATH="$PATH:`pwd`/flutter/bin"
                    flutter pub get
                '''
            }
        }

        stage('Rodar Testes') {
      steps {
        sh '''
                    export PATH="$PATH:`pwd`/flutter/bin"
                    flutter test integration_test/
                '''
            }
        }
    }

    post {
    always {
      echo 'Pipeline finalizada.'
        }
        success {
      echo '🎉 Build e Testes passaram!'
        }
        failure {
      echo '❌ Falhou em algum estágio.'
        }
    }
}

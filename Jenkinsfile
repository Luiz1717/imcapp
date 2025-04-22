pipeline {
  agent any

  environment {
    FLUTTER_HOME = '/opt/flutter'
    PATH = "${env.FLUTTER_HOME}/bin:${env.PATH}"
  }

  stages {
    stage('Preparar ambiente') {
      steps {
        echo 'Verificando versão do Flutter'
        sh 'flutter --version'
      }
    }

    stage('Checkout') {
      steps {
        git 'https://github.com/Luiz1717/imcapp'
      }
    }

    stage('Instalar dependências') {
      steps {
        sh 'flutter pub get'
      }
    }

    stage('Analisar código') {
      steps {
        sh 'flutter analyze'
      }
    }

    stage('Executar testes') {
      steps {
        sh 'flutter test'
      }

    }
      }
    }
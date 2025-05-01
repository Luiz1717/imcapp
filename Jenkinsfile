pipeline {
    agent any

    environment {
        FLUTTER_VERSION = '3.29.3'
        FLUTTER_HOME = "${env.WORKSPACE}/flutter"
        PATH = "${env.FLUTTER_HOME}/bin:${env.PATH}"
        PUB_CACHE = "${env.WORKSPACE}/.pub-cache"
    }

    stages {
        stage('Clonar Projeto') {
            steps {
                git url: 'https://github.com/Luiz1717/imcapp.git',
                     branch: 'master'
            }
        }

        stage('Instalar Flutter') {
            steps {
                script {
                    // Check and install Flutter if needed
                    if (!fileExists("${env.FLUTTER_HOME}/bin/flutter")) {
                        sh """
                            git clone https://github.com/flutter/flutter.git --branch ${FLUTTER_VERSION} ${env.FLUTTER_HOME}
                            ${env.FLUTTER_HOME}/bin/flutter precache
                        """
                    }
                    
                   
                    def flutterVersion = sh(script: 'flutter --version', returnStdout: true).trim()
                    echo "Flutter version: ${flutterVersion}"
                    
                 
                    def doctorOutput = sh(script: 'flutter doctor', returnStatus: true)
                    if (doctorOutput != 0) {
                        error('Flutter doctor reported issues!')
                    }
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
                    flutter test
                    flutter test integration_test
                '''
            }
        }

        stage('Build APK') {
            steps {
                script {
                 
                    sh 'flutter clean'
                    
                  
                    sh 'flutter build apk --release --no-sound-null-safety --verbose'
                    
               
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
                    
                  
                    def buildInfo = sh(script: 'flutter build apk --release --build-number=${BUILD_NUMBER}', returnStdout: true)
                    echo "Build info: ${buildInfo}"
                }
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

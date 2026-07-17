pipeline {
    agent any 
    tools {
         maven 'maven'
         jdk 'java'
    }
    stages {
         stage('Stage-0 : Static Code Analysis Using SonarQube') { 
           steps {
                sh 'mvn clean verify sonar:sonar'
               // -Dsonar.host.url=http://54.234.216.203:9000 -Dsonar.login=sqp_8f13915ee2350315aaebd9acd6a479ba3598dbb0'
            }
        }
        stage('Stage-1 : Clean') { 
            steps {
                sh 'mvn clean'
            }
        }
         stage('Stage-2 : Validate') { 
            steps {
                sh 'mvn validate'
            }
        }
         stage('Stage-3 : Compile') { 
            steps {
                sh 'mvn compile'
            }
        }
         stage('Stage-4 : Test') { 
            steps {
                sh 'mvn test'
            }
        }
          stage('Stage-5 : Install') { 
            steps {
                sh 'mvn install'
            }
        }
          stage('Stage-6 : Verify') { 
            steps {
                sh 'mvn verify'
            }
        }
          stage('Stage-7 : Package') { 
            steps {
                sh 'mvn package'
            }
        }
           stage('Stage-8 : Deploy an Artifact to Artifactory Manager i.e. Nexus/Jfrog') { 
            steps {
                sh 'mvn deploy'
            }
        }
          stage('Stage-9 : Deployment - Deploy a Artifact devops-2.0.0-SNAPSHOT.war file to Tomcat Server') { 
            steps {
                // Tomcat Server IP Address
               //sh 'curl -u admin:home@123 -T target/devops.war "http://32.199.190.107:8080/manager/text/deploy?path=/cbapp&update=true"'
               sh 'curl -u admin:home@123 -T target/devops.war "http://32.199.190.107:8080/manager/text/deploy?path=/cbapp&update=true"'
            }
        } 
  
          stage('Stage-10 : SmokeTest') { 
            steps {
                  // Tomcat Server IP Address
                sh 'curl --retry-delay 10 --retry 5 "http://32.199.190.107:8080/cbapp"'
            }
        }


    }
}

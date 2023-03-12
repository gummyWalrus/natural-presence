pipelineJob('DeployGKE') {
  parameters {
      stringParam('DOMAIN', 'caucheteux.cloud', 'Le nom de domaine où déployer votre infra')
  }
  definition {
    cps {
      script(
        '''
        pipeline{
    agent any
    parameters {
        string(name: 'DOMAIN', defaultValue: 'caucheteux.cloud', description: 'Domain name')
    }
    environment {
        PROJECT_ID = 'natural-presence'
        CLUSTER_NAME = 'natural-presence'
        LOCATION = 'europe-west1-b'
        CREDENTIALS_ID = 'natural-presence'
    }

    stages{
        stage('checkout git'){
            steps{
                 git branch: 'master',
               url:'https://github.com/gummyWalrus/natural-presence.git'
            }
           
        }
        
        stage('Replace domain names') {
            steps {
              script {
                def DOMAIN = params.DOMAIN
                def cvManifest = readFile './kube/cv.yml'
                def frontendManifest = readFile './kube/frontend.yml'
                def blogManifest = readFile './kube/blog.yml'
                def backendManifest = readFile './kube/backend.yml'
                def portofolioEnv = readFile './portofolio/.env.prod'
                def blogEnv = readFile './blog/.env.prod'
                def appEnv = readFile './app/.env.prod'

                cvManifest = cvManifest.replaceAll('caucheteux.cloud', "${DOMAIN}")
                frontendManifest = frontendManifest.replaceAll('caucheteux.cloud', "${DOMAIN}")
                blogManifest = blogManifest.replaceAll('caucheteux.cloud', "${DOMAIN}")
                backendManifest = backendManifest.replaceAll('caucheteux.cloud', "${DOMAIN}")
                portofolioEnv = portofolioEnv.replaceAll('caucheteux.cloud', "${DOMAIN}")
                blogEnv = blogEnv.replaceAll('caucheteux.cloud', "${DOMAIN}")
                appEnv = appEnv.replaceAll('caucheteux.cloud', "${DOMAIN}")

                writeFile file: './kube/cv.yml', text: cvManifest
                writeFile file: './kube/frontend.yml', text: frontendManifest
                writeFile file: './kube/blog.yml', text: blogManifest
                writeFile file: './kube/backend.yml', text: backendManifest
                writeFile file: './portofolio/.env.prod', text: portofolioEnv
                writeFile file: './blog/.env.prod', text: blogEnv
                writeFile file: './app/.env.prod', text: appEnv
              }
            }
        }

       stage('Docker build all images'){
        steps{
            script{
                sh 'docker build -t lanico/natural-presence-cv:latest app/ '
                sh 'docker build -t lanico/natural-presence-blog:latest blog/ '
                sh 'docker build -t lanico/natural-presence-frontend:latest portofolio/ '
            }
        }
       }
       stage('Docker login and push all images'){
        steps{
            withCredentials([string(credentialsId: 'docker_hub_token', variable: 'TOKEN')]) {
            sh 'docker login -u lanico -p $TOKEN'

            sh 'docker push lanico/natural-presence-frontend:latest'
            sh 'docker push lanico/natural-presence-blog:latest'
            sh 'docker push lanico/natural-presence-cv:latest'
        }

       }
       }


       stage('Deploy to kubernetes'){
        steps{
            		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/backend.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: false])
		    echo "Deployed backend ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/frontend.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: false])
		    echo "Deployed frontend ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/cv.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: false])
		    echo "Deployed cv ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/blog.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: false])
		      echo "Deployed blog ..."
          echo "Finished deployment"
        }
       }

    }
}
        '''
      )
      sandbox()
    }
  }
}
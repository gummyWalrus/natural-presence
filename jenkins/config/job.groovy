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
                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'kube/cv.yaml',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'kube/frontend.yaml',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'kube/blog.yaml',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'kube/backend.yaml',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'portofolio/.env.prod',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'blog/.env.prod',
                    )
                  ]
                )

                contentReplace(
                  configs: [
                    fileContentReplaceConfig(
                      configs: [
                        fileContentReplaceItemConfig(
                          search: 'caucheteux.cloud',
                          replace: '${DOMAIN}',
                          matchCount: 0,
                          verbose: true,
                        )
                      ],
                      fileEncoding: 'UTF-8',
                       'app/.env.prod',
                    )
                  ]
                )
            }
        }

       stage('Docker build all images'){
        steps{
            script{
                sh 'cd app'
                sh 'docker build -t lanico/natural-presence-cv:latest . '
                sh 'cd ../blog'
                sh 'docker build -t lanico/natural-presence-blog:latest . '
                sh 'cd ../portofolio'
                sh 'docker build -t lanico/natural-presence-frontend:latest . '
                sh 'cd ../directus'
                sh 'docker build -t lanico/natural-presence-db:latest . '
            }
        }
       }
       stage('Docker login and push all images'){
        steps{
            withCredentials([string(credentialsId: 'docker_hub_token', variable: 'TOKEN')]) {
            sh 'docker login -u lanico -p $TOKEN'

            sh 'docker push lanico/natural-presence-frontend:latest'
            sh 'docker push lanico/natural-presence-blog:latest'
            sh 'docker push lanico/natural-presence-portofolio:latest'
            sh 'docker push lanico/natural-presence-db:latest'
        }

       }
       }


       stage('Deploy to kubernetes'){
        steps{
            
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/db.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		    echo "Deployed database ..."
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/backend.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		    echo "Deployed backend ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/frontend.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		    echo "Deployed frontend ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/cv.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		    echo "Deployed cv ..."
		    
		    
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kube/blog.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		    echo "Deployed blog ..."
            echo "Finished deployment"
        }
       }

    }
}

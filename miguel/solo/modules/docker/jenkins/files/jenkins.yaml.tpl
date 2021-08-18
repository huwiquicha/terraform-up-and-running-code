jenkins:
    systemMessage: "Amazon Fargate Demo"
    numExecutors: 2
    remotingSecurity:
      enabled: true
    agentProtocols:
        - "JNLP4-connect"
    securityRealm:
        local:
            allowsSignup: false
            users:
                - id: jenkins_user
                  password: ${jenkins_user_pwd}
    authorizationStrategy:
        globalMatrix:
            grantedPermissions:
                - "Overall/Read:anonymous"
                - "Job/Read:anonymous"
                - "View/Read:anonymous"
                - "Overall/Administer:authenticated"
    crumbIssuer: "standard"
    slaveAgentPort: 50000
credentials:
    system:
        domainCredentials:
            - credentials:
                - bitbucketTokenCredentialsImpl:
                    id: "bitbucket_access_token"
                    description: "BitBucket Access Token"
                    secret: ${bitbucket_access_token}
                - usernamePassword:
                    scope: GLOBAL
                    id: "bitbucket_build_credentials"
                    username: bitbucket_user
                    password: ${bitbucket_user_pwd}
                    description: "BitBucket Build Credentials"
security:
  sSHD:
    port: -1
unclassified:
    bitbucketpluginconfiguration:
        serverList:
            - id: "BitBucket-Miguel"
              adminCredentialsId: "bitbucket_access_token"
              baseUrl: "${bitbucket_url}"
              serverName: "BitBucket-Miguel"
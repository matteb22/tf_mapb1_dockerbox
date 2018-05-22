pipeline {
  agent {
  docker {image 'softtekcoe/terraform:0.11.3'}
  }
  environment {
  AWS_ACCESS_KEY_ID = credentials('aws_access_key')
  AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
  TF_VAR_aws_key_name = 'mbottini-softtek'
  TF_VAR_my_private_key_path = credentials('mbottini-softtek')
  }
  stages {
    stage('init') {
      steps {
      sh 'terraform init -input=false'
      }
  }
  stage('plan') {
    steps {
    sh 'terraform plan -out=plan -input=false'
    }
  }
  stage('apply') {
    steps {
      sh 'terraform apply -input=false plan'
    }
  }
  stage('test') {
    steps {
      sh 'sleep 180'
    }
  }
  stage('destroy') {
    steps {
      sh 'terraform destroy -force -input=false'
    }
  }
}
}

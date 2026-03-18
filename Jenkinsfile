pipeline {
    agent any

    environment {
        // 앱 및 이미지 설정
        APP_NAME        = 'stock_report'
        IMAGE_NAME      = 'stock_report_image'
        IMAGE_TAG       = "${BUILD_NUMBER}"
        CONTAINER_NAME  = 'stock_report_c'
        
        // 포트 설정
        APP_PORT        = '8008'
        HOST_PORT       = '34467'
    }

    stages {

        stage('Docker Build') {
            steps {
                // Docker 이미지 빌드
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Deploy Container') {
            steps {
                sh """
                # 기존 컨테이너가 있다면 삭제
                docker rm -f ${CONTAINER_NAME} || true
                
                # 새 컨테이너 실행
                docker run -d \
                    --name ${CONTAINER_NAME} \
                    -p ${HOST_PORT}:${APP_PORT} \
                    ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        success {
            echo "백엔드(Maven) App 배포 성공: ${IMAGE_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo '백엔드(Maven) App 배포 실패'
        }
    }
}
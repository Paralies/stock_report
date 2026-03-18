# 1. 빌드 스테이지: JDK와 Maven이 모두 포함된 이미지를 사용합니다.
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app

# pom.xml 복사 및 의존성 다운로드
COPY pom.xml .
RUN mvn dependency:go-offline -B

# 소스 코드 복사 및 패키징
COPY src ./src
RUN mvn package -DskipTests

# 2. 실행 스테이지: 실행에는 JRE만 있으면 되므로 가벼운 이미지를 사용합니다.
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
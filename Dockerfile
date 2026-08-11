# =============================================
# Stage 1：使用 Maven 編譯專案，產出 JAR 檔
# =============================================

FROM maven:3.9-eclipse-temurin-17-alpine AS builder

WORKDIR /mythymeleaf0811

# 複製完整專案
COPY . .

# Maven 編譯並產生 JAR
RUN mvn clean package -DskipTests


# =============================================
# Stage 2：執行 Spring Boot
# =============================================

FROM eclipse-temurin:17-jre-alpine

WORKDIR /mythymeleaf0811

# ★ 這裡要跟 Stage 1 的 WORKDIR 一致
COPY --from=builder /mythymeleaf0811/target/*.jar mythymeleaf.jar

# Render 使用 8080
EXPOSE 8080

# 啟動 Spring Boot
ENTRYPOINT ["java", "-jar", "mythymeleaf.jar"]
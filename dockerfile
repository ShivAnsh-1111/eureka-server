# Use an official Java runtime as a parent image
FROM openjdk:17-jdk-slim AS build

# Set working directory for building the JAR
WORKDIR /app

# Copy Maven wrapper files and pom.xml first (to cache dependencies)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies first (for better caching)
RUN chmod +x mvnw && ./mvnw dependency:go-offline

# Copy the source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Use a smaller runtime image
FROM openjdk:17-jdk-slim

# Set environment variables
ENV PROFILE=PRODUCTION
ENV EUREKA_DEFAULT=https://eureka-server-yzjr.onrender.com/eureka/
ENV SERVER_PORT=8761
ENV HOSTNAME=""
ENV POD_IP=""
ENV RANDOM_VALUE=""
ENV spring.application.name=""

# Set the working directory in the container
WORKDIR /app

# Copy the generated JAR from the build stage
COPY --from=build /app/target/eureka-server-*.jar eureka-server.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8761

# Run the JAR file
ENTRYPOINT ["java", "-jar", "eureka-server.jar"]

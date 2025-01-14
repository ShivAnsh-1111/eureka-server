# Use an official Java runtime as a parent image
FROM openjdk:17-jdk-slim

# Set environment variables
ENV PROFILE=PRODUCTION
ENV EUREKA_DEFAULT=http://44.227.217.144/eureka/
ENV SERVER_PORT=8761
ENV HOSTNAME=chess-server
ENV POD_IP=44.227.217.144
ENV RANDOM_VALUE=1234

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/eureka-server-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8761

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]

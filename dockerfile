# Use an official Java runtime as a parent image
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

# Copy the JAR file into the container
COPY target/eureka-server-0.0.1-SNAPSHOT.jar eureka-server.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8761

# Run the JAR file
ENTRYPOINT ["java", "-jar", "eureka-server.jar"]

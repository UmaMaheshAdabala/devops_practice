### **Dockerfile for a Java-based Spring Boot Application**

A **Dockerfile** is used to containerize your **Spring Boot** application so that it can run in any environment. Below, I'll explain **how to write a Dockerfile step by step**, from basic to advanced, following **industrial standards**.

---

## **🔹 Step 1: Writing a Basic Dockerfile**

This Dockerfile:  
✅ Uses **OpenJDK 17** as the base image.  
✅ Copies the **Spring Boot JAR file** to the container.  
✅ Runs the application inside the container.

### **Basic Dockerfile**

```dockerfile
# Use an official Java runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/springboot-app.jar app.jar

# Expose the application port (Change if your app runs on a different port)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
```

---

### **🔹 Step 2: Multi-Stage Dockerfile (Optimized for Production)**

A **multi-stage build** reduces the final image size by:  
✅ Using a **build image** to compile the Spring Boot app.  
✅ Copying only the **final JAR file** to a **runtime image**.

```dockerfile
# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight runtime image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy only the built JAR file from the previous stage
COPY --from=build /app/target/springboot-app.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
```

---

### **🔹 Step 3: Dockerfile with Environment Variables and Health Check**

✅ Uses **environment variables** for flexibility.  
✅ Adds **a health check** to ensure the container is running properly.

```dockerfile
# Use OpenJDK 17 runtime
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy JAR file
COPY target/springboot-app.jar app.jar

# Expose application port
EXPOSE 8080

# Set environment variables (can be overridden at runtime)
ENV JAVA_OPTS="-Xmx512m"

# Run the application with environment variables
CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]

# Add a health check to restart container if app fails
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
```

---

### **🔹 Step 4: Build and Run the Docker Image**

#### **1️⃣ Build the Docker Image**

```sh
docker build -t your-docker-hub-username/springboot-app .
```

#### **2️⃣ Run the Docker Container**

```sh
docker run -p 8080:8080 your-docker-hub-username/springboot-app
```

#### **3️⃣ Run with Custom Memory Limits**

```sh
docker run -p 8080:8080 -e JAVA_OPTS="-Xmx1g" your-docker-hub-username/springboot-app
```

---

### **🔹 Step 5: Push Docker Image to Docker Hub**

1. **Login to Docker Hub**
   ```sh
   docker login
   ```
2. **Tag the image**
   ```sh
   docker tag springboot-app your-docker-hub-username/springboot-app:latest
   ```
3. **Push the image**
   ```sh
   docker push your-docker-hub-username/springboot-app:latest
   ```

---

### **🎯 Summary**

1. **Basic Dockerfile** → Creates a simple container for Spring Boot.
2. **Multi-Stage Build** → Reduces final image size.
3. **Optimized Dockerfile** → Uses environment variables & health checks.
4. **Build & Run** → `docker build` and `docker run`.
5. **Push to Docker Hub** → `docker push`.

Would you like help setting up a Kubernetes deployment using this Docker image? 🚀

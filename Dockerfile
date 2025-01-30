# Use an official OpenJDK 8 base image
FROM openjdk:8-jdk-slim

# Install required packages and Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip -O /tmp/gradle.zip && \
    unzip /tmp/gradle.zip -d /opt && \
    mv /opt/gradle-4.10.2 /opt/gradle && \
    rm /tmp/gradle.zip && \
    # Clean up to reduce image size
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV GRADLE_HOME /opt/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Create and set working directory
WORKDIR /app

# Verify installations (optional)
RUN java -version && gradle -v

# Default command to check gradle
CMD ["gradle", "-v"]

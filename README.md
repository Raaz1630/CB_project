**Java Web Application - Project Documentation**

**Project Overview**

**Project Title: CI/CD pipeline job using AWS tools on Java Web Application**

           This project is a Java-based web application developed using the Spring Boot framework. The primary focus is to implement a continuous integration and continuous deployment (CI/CD) pipeline for automating the software development lifecycle, ensuring efficient delivery of high-quality code.

           The application performs typical web application functions, including handling requests, interacting with a database, and managing resources such as products and orders. The system is designed with robust monitoring and logging features using AWS services, enabling efficient management and troubleshooting.

**Key Features:**
 
  **Spring Boot:** A lightweight, flexible framework for building Java-based web applications.
  
  **Database Integration:** PostgreSQL is used in production, while H2 is used for testing purposes.
  
  **Artifact Management:** The project utilizes Amazon S3 to store versioned build artifacts.
  
  **Automated CI/CD Pipeline:** The CI/CD pipeline is implemented using AWS CodeBuild, facilitating automated builds, testing, and deployments.
  
  **Cloud Monitoring:** Application health and performance are monitored using AWS CloudWatch, providing visibility into system performance.

**Technologies Used:**

  Programming Language: Java 17
 
  Framework: Spring Boot 3.3.3

  Database: PostgreSQL for production, H2 for testing

  Version Control: GitHub
  
  Build Tool: Maven

  Web Server: Apache Tomcat
  
  Code Quality Tool: SonarQube
  
  Artifact Storage: AWS S3
  
  Monitoring: AWS CloudWatch

**Project Requirements:**

**Software:**

  Java 17: Required for compiling and running the application.
  
  Maven: For project management and build automation.

  Apache Tomcat: Web server for hosting the web application.
  
  AWS CLI: Command-line tool for interacting with AWS services.
  
  SonarQube: For continuous code quality checks.
  
  Amazon S3: Storage for build artifacts (WAR files).

**Infrastructure:**

  EC2 Instances: Hosting SonarQube and Apache Tomcat servers.

  Amazon S3: For storing WAR files and versioned artifacts.
  
  AWS CloudWatch: For application and infrastructure monitoring.

**Version Control**

  Tool: Git
  
  Repository Hosting: GitHub

**CI/CD Pipeline using AWS CodeBuild**

**Continuous Integration (CI)**

  CI ensures that every code change is tested and integrated into the main branch frequently, avoiding integration issues.

  Automated Build Process: The project uses a buildspec.yml file to define the build steps.

  Buildspec.yml specifies the sequence of build, test, and deploy steps, ensuring consistency across all builds.
  
**Code Quality Analysis**
  
  Tool: SonarQube
  
  SonarQube Integration: Integrated into the CI pipeline to analyze the code for bugs, vulnerabilities, and code smells.
  
  SonarQube Server: Hosted on EC2 instance and accessible for analysis.
  
  ProjectKey: The Capstone project is defined in SonarQube for tracking quality metrics.
  
**Continuous Deployment (CD)**
  
  After passing the CI phase, the application is deployed automatically.

  Artifact Management: Built artifacts (WAR files) are uploaded to Amazon S3 for version control and storage.

  Automated Deployment: Deploy the application automatically to Apache Tomcat after the quality gate passes in SonarQube.

  

![Screenshot 2024-09-20 164640](https://github.com/user-attachments/assets/dd46d806-e36c-4a4a-b9fd-940016f558a2)






![Screenshot 2024-09-20 164654](https://github.com/user-attachments/assets/942b4dd9-6e13-4d4e-97d8-0932844c73ad)


**SonarQube**

  Code Quality Checks

  SonarQube performs static code analysis, identifying issues like bugs, vulnerabilities, code smells, and duplicate code.

  Quality Gates: The pipeline only proceeds to deployment if the SonarQube quality gate passes, ensuring code quality is maintained.
  
  **Criteria for passing**:

     No critical bugs or vulnerabilities

     No security hotspots
     
     Code coverage threshold (e.g., >80%)

**SonarQube Setup**

  1. Install SonarQube on EC2: 
    
     Follow the SonarQube installation guide to set up on an EC2 instance.

     Configure your SonarQube instance to be accessible from the pipeline.
  
  2. Create SonarQube Project:

     Name the project Capstone in SonarQube and note the project key for use in the buildspec.yml file.
  
  3. Configure Quality Gates:

     In SonarQube, configure the quality gate settings to ensure code meets defined thresholds before deployment.


![Screenshot 2024-09-20 164625](https://github.com/user-attachments/assets/67a5dcf2-83f1-4eed-8192-e7814fdd58c8)


     
**S3 Artifact Storage**

  S3 Bucket Setup

   Artifacts, such as JAR/WAR files, are stored in Amazon S3.

     Bucket Name: project-capstone

     Versioning: Enabled to keep track of every version of the artifacts.
   
                 This allows rollback to previous versions in case of deployment failures.
   
   Storing and Retrieving Artifacts
   
     Upload to S3: After a successful build, the WAR file is uploaded to S3.

     
   
     Download for Deployment: When deploying, the application downloads the correct artifact from S3.
     

![Screenshot 2024-09-20 165056](https://github.com/user-attachments/assets/62628403-4463-4aff-b7ee-30a63a47d577)



 **Apache Tomcat Deployment**

  Deployment Strategy
      
     Zero-Downtime Deployment: Automate deployment using CodeBuild to minimize downtime.
  
     Tomcat Location: WAR files are deployed to the /opt/tomcat/webapps directory on the server.

  Automated Deployment Workflow

     WAR Upload: The WAR file is uploaded to the S3 bucket.
     
     Tomcat Deployment: A deployment script pulls the WAR file from S3 and deploys it to the Tomcat server 
     

![Screenshot 2024-09-20 164544](https://github.com/user-attachments/assets/b2520dec-ebe9-402f-8817-225a6922d1f2)



**AWS CloudWatch Monitoring**

  Application Monitoring
  
  AWS CloudWatch is configured to monitor key metrics for both the application and the Tomcat server:

   Metrics Monitored:
     
     CPU Usage: To monitor the CPU consumption of the application.
     
     Memory Utilization: Ensure memory consumption is within safe thresholds.
     
     Disk Space: Monitor available disk space to prevent application crashes due to storage issues.
     
     Custom Metrics: Application-specific metrics (e.g., active user sessions, order processing times).

  CloudWatch Alarms

     Set up alarms for critical events:

     CPU/Memory Spikes: If CPU or memory utilization exceeds a threshold, trigger an alarm to notify the DevOps team.

     Application Downtime: Set up a heartbeat monitor to ensure the application is running. If the heartbeat fails, trigger an alarm.

  Log Streaming

     Tomcat Logs: Stream logs from catalina.out to CloudWatch for centralized logging.
     
     Log Group: /tomcat-logs with a stream for each instance.     

**Challenges Faced and Solutions**

  1. Issues Copying Artifact from S3 to Tomcat

     Challenge: There were challenges when copying the build artifact (WAR file) from the S3 bucket to the Tomcat server. The AWS S3 command failed due to insufficient permissions and incorrect S3 bucket paths.

     Solution: I resolved the issue by updating the S3 access permissions and correcting the path used in the AWS CLI command. I ensured that the correct IAM roles and policies were applied to the pipeline and the server, allowing the artifact to be copied from S3 to the Tomcat server successfully. 

  2. Improper Deployment of WAR File in Tomcat
     
     Challenge: During the initial setup, there was an issue with deploying the WAR file to Tomcat. The problem stemmed from an incorrect command in the buildspec.yml file, which prevented the successful deployment of the application.

     Solution: The error was identified in the deployment step of the pipeline. I corrected the command in the buildspec.yml, ensuring the correct path was used for copying the WAR file from the build output to Tomcat's webapps directory. This change allowed the pipeline to deploy the WAR file smoothly.

**Final Outcome**

     After resolving the challenges related to WAR file deployment and artifact management, the application was successfully deployed on the Apache Tomcat server. The CI/CD pipeline ensured seamless integration, code quality checks, and deployment. Upon deployment, the application was tested, and it opened successfully in the browser


![Screenshot 2024-09-20 165320](https://github.com/user-attachments/assets/f9ac6723-e0ac-47a1-9efc-76624ab7d15a)  


**Conclusion**

     As a DevOps engineer, the main objective of this project was to create an automated CI/CD pipeline for a Java web application using AWS tools. Throughout this project, I successfully developed and deployed an E-Commerce Inventory Management System that helps manage products, track inventory, and process orders.

    The CI/CD pipeline was built using AWS CodeBuild, S3, for integration and deployment. It included SonarQube for code quality checks, ensuring that only error-free code was deployed. The pipeline deployed the application to an Apache Tomcat server hosted on an EC2 instance, enabling smooth, zero-downtime deployments.

    Though there were challenges, such as issues with deploying the WAR file and copying artifacts from S3 to Tomcat, I resolved them by fixing the buildspec.yml file and correcting S3 permissions. These solutions resulted in a smooth and successful deployment of the application.

    AWS CloudWatch was used for monitoring, providing real-time tracking of the application’s performance and health. Alerts were set up to notify the team in case of any problems.

Overall, this project demonstrates the value of automating deployments to deliver features quickly, reliably, and securely, highlighting the importance of DevOps in modern software development.



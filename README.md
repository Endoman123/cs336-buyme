# cs336-buyme

CS336 final project, an online auction site.

## Requirements

- **JDK:** Version 11 or higher
- **MySQL**: Version 8.0 or higher
  - *NOTE: You can build the Dockerfile included with the project to have a containerized instance of the database.*

## Building with Gradle

You can simply use the `war` task to compile to a WAR for deployment with Tomcat Apache or any other Java EE Webserver.

## Testing with Gradle

The `tomcat` gradle plugin comes with some tasks to allow you to run a Tomcat container through Gradle.

- `tomcatRun`: Run Tomcat with files in-place, which allows for hot-swapping code.
- `tomcatRunWar`: Compiles the code base into a WAR, which is then run in a Tomcat container.
- `tomcatStop`: Required to run after stopping any of the `tomcatRun` tasks to stop the Tomcat container.

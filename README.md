# cs336-buyme

CS336 final project, an online auction site.

## Requirements

- **JDK:** Version 11 or higher
- **MySQL**: Version 8.0 or higher

## Building

You can simply use the `war` task to compile to a WAR for deployment with Tomcat Apache or any other Java EE Webserver. Compiled WAR files are located in `build/libs`

## Testing

For a standardized build of MySQL and the starting database to use for the application, you can use `docker-compose` to spin up a MySQL server and PHPMyAdmin interface. SQL files located in `src/main/sql` will be used to initialize the database. The servers can be accessed as follows:

- MySQL: `localhost:8080`
- PHPMyAdmin: `localhost:8088`

For running a standardized Tomcat instance, the `tomcat` gradle plugin comes with some tasks to allow you to run a Tomcat container through Gradle.

- `tomcatRun`: Run Tomcat with files in-place, which allows for hot-swapping code.
- `tomcatRunWar`: Compiles the code base into a WAR, which is then run in a Tomcat container.
- `tomcatStop`: Required to run after stopping any of the `tomcatRun` tasks to stop the Tomcat container.

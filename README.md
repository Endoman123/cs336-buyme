# cs336-buyme

CS336 final project, an online auction site.

## Requirements

- **JDK:** Version 11 or higher
- **MySQL**: Version 8.0 or higher

## Gradle

The project is backed by the Gradle build tool. 
In order to run any of the tasks below, you can either interface with it via your IDE,
or by using the `gradlew` script included in the project:

- Windows: `gradlew.bat <task>`
- *NIX (macOS, Linux, BSD, etc.): `./gradlew <task>`

## Building

You can simply use the `war` task to compile to a WAR for deployment with Tomcat Apache or any other Java EE Webserver. 
Compiled WAR files are located in `build/libs`.

## Testing

For a standardized build of MySQL and the starting database to use for the application, you can use `docker-compose` to spin up a MySQL server and PHPMyAdmin interface. SQL files located in `src/main/sql` will be used to initialize the database. The servers can be accessed as follows:

- MySQL: `localhost:3306`
- PHPMyAdmin: `localhost:8088`

For running a standardized Tomcat instance, the `tomcat` gradle plugin comes with some tasks to allow you to run a Tomcat container through Gradle.
Due to limitations with the `tomcat` plugin, hotswapping Java classes is not possible, however JSP hotswapping is still available.

- `tomcatRun`: Run Tomcat with files in-place.
- `tomcatRunWar`: Compiles the code base into a WAR, which is then run in a Tomcat container.
- `tomcatStop`: Required to run after stopping any of the `tomcatRun` tasks to stop the Tomcat container.

The container can be accessed at `http://localhost:8090/cs336-buyme`.

## Credentials
Listed below are the test credentials currently registered with the webapp:
| Login   | Password    | Type |
|--------------- | --------------- | --------------- |
| admin   | admin   | `ADMIN`
| rep   | rep  | `CUSTOMER_REP`
| dorianht   | password1   | `END_USER`
| endoman123   | password2   | `END_USER`
| muskanb12   | password3   | `END_USER`
| windhollow   | password4   | `END_USER`

## Features
1. [x] Create accounts of users; login, logout.
2. [-] Auctions (Manual)
    * [x] seller creates auctions and posts items for sale
        - [x] set all the characteristics of the item
        - [x] set closing date and time
        - [x] set a hidden minimum price (reserve)
    * [x] a buyer should be able to bid
        - [x] let the buyer set a new bid
        - [x] alert other buyers of the item that a higher bid has been placed 
    * [x] define the winner of the auction
        - [x] when the closing time has come, check if the seller has set a reserve
            * [x] if yes: if the reserve is higher than the last bid none is the winner.
            * [x] if no: whoever has the higher bid is the winner
                - [x] alert the winner that they won the auction
3. [x] Auctions (Automatic)
    * [x] a buyer should be able to set an automatic bidding
        - [x] set a secret upper limit
        - [x] set a bid increment (put in the database a higher bid automatically for the user in       
       case someone bids higher)
        - [x] alert buyers in case someone bids more than their upper limit 
    * [x] define the winner of the auction
        - [x] when the closing time has come, check if the seller has set a reserve
            * [x] if yes: if the reserve is higher than the last bid none is the winner.
            * [x] if no: whoever has the higher bid is the winner
                - [x] alert the winner that they won the auction
4. [x] Browsing and advanced search functionality
    * [x] let people browse on the items and see the status of the current bidding
    * [x] sort by different criteria (by type, bidding price etc.)
    * [x] search the list of items by various criteria.
    * [x] a user should be able to:
        - [x] view all the history of bids for any specific auction
        - [x] view the list of all auctions a specific buyer or seller has participated in
        - [x] view the list of "similar" items on auctions in the preceding month (and auction information about them)
    * [x] let user set an alert for specific items s/he is interested 
        - [x] get an alert when the item becomes available
5. [-] Admin and customer rep functions
    * [x] Admin (create an admin account ahead of time)
        - [x] creates accounts for customer representatives
        - [-] generates sales reports for:
            * [x] total earnings
            * [-] earnings per:
                - [x] item
                - [] item type
                - [x] end-user
            * [x] best-selling items
            * [x] best buyers
    * [x] Customer representative functions:
        - [x] users browse questions and answers
        - [x] users search questions by keywords
        - [x] users post questions to the customer representatives (i.e. customer service)
        - [x] reps reply to user questions
        - [x] edits and deletes account information
        - [x] removes bids 
        - [x] removes auctions 

## Contribution
- Nikita Belausav (windhollow): Browsing and advanced search functionality
- Muskan Burman (muskanb12): Auctions (Manual)
- Dorian Hobot (dorianht): Auctions (Automatic)
- Jared Tulayan (endoman123): Admin and Customer Rep functions
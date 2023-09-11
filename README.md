# Weather App by Abdelsalam Morsy

## Architecture
I have decided to use **MVP-C** architecture, where:
- **Model:** is responsible for managing the data and business logic of the application.
- **View:** is responsible for displaying the UI components and receiving user interactions. 
- **Presenter:** act as a mediator between model and view, handling user interactions and updating the view or model.
- **Coordinator:** is responsible for routing and navigation between different views.

## Folder Structure
![Uploading Screenshot 2023-09-11 at 9.32.19 PM.png…]()

## Unit Test
I did unit test for **TemperaturePresenter** as *an example*. To achieve this, I created mock implementations for **WeatherService** and **LocationService** to simulate both successful and failed responses.

## Git Flow
I checked out the *develop* branch from the *master* branch and pushed all my changes to it because I am working alone. However, I used to use Git flow when working with a team.
**Git flow:**
- master branch.
- develop branch.
- feature branch.
- task branch.
- release branch.
- hotfix branch.


*If you have any questions, please do not hesitate to contact me.*



# Falling Words

### How much time invested

It took me around 7-9 hours to complete this project

### How time was distributed

I dont measure the time but I started with writting a user story and extract the buisness logic from it. I write my game's logic separately. I then make wireframe roughly to get the visual idea of the aplication. 

Then I create the project, and after creating repo and setting up the project structure, I implement the UI of the app. After creating the UI, I work on the UseCase that is exposed to UI. I create the Models, UseCase implementation and filled it with fake data. Using that data I completed the game and tested it. This ensures that with given data, my UI works as I want it to be.

Then I writes the UseCase where all the buisness logic sits. It takes the most of my time as it has all the brain of the app.

Then I writes the Data layer that provides the data to Domain layer .

Lastly, after testing it, I cover my buisness logic with Unit tests.

### Decisions made because of restricted time

- Limited testing
- Limited code review
- Limited automated testing ( UITesting, Snapsot testing)
- GamePlayUseCase class can further be reduce into a class that manages the answer by user .
- Do not add readme, high scores etc
- Simple animations and feedback on user choices
- Simple game logic by restricting the total options for a given word to four or less

### What would be the first thing to improve or add if there had been more time

User experience by adding more animations, better feedback, a user manual, more testing  and making game more intresting by adding levels and difficulty levels etc.






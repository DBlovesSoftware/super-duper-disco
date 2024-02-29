Blackhole blackhole; // global variables for blackhole
Earth earth; // global variables for earth
Spaceship spaceship; // global variables for spaceship
Astronaut astronaut; // global variables for astronaut
Spacestation spacestation; // global variables for spacestation
HomePage homePage; // global variables for homepage
RulesPage rulesPage; // global variables for rulespage
EndPage endPage; // global variables for endpage

PImage backGround; //using PImage to call an image
int bgX = 0; //bgX - background frame rate
int score = 0; // variable for recorded score

// variables to represent state of the game
final int HOMEPAGE = 0; //constant variable for homepage
final int PLAYING = 1; //constant variable for game
final int RULESPAGE = 2; // constant variable for rules
final int GAMEOVER = 3; // constant variable for endpage
int gameMode = HOMEPAGE; // sets initiable page to gamemode


int currentPage;
int startTime;
int currentLevel = 1;
int highScore = 0;
int newHighScore = 0;
int initialTime = 20000; // Initial time in milliseconds
int timeDecreaseRate = 3000; // Time decreases by  second per level
boolean timerActive = false;

//array list create multiple instances of the draggable objects
ArrayList<Asteroid> asteroidList = new ArrayList<>(); //array list for asteroids
ArrayList<Spaceship> spaceshipList = new ArrayList<>();//array list for asteroids
ArrayList<Astronaut> astronautList = new ArrayList<>();//array list for asteroids
ArrayList<Astronaut> astronautsToRemove = new ArrayList<>();//array list for to respawn asteroids removed
ArrayList<Spaceship> spaceshipsToRemove = new ArrayList<>();  //array list for to respawn spaceships when removed

void setup() {
  size(1000, 800); //size of canvas (can be changed)
  initializePages(); //when pages are called
  initializeGameElements(); //when objects are respawned for next level
  setupGame(); //to reset timer for next level
  loadObjects(); // to display objects on page
  loadBackgroundImage(); // to display the game background
  initializeHighScore(); // to diplsay the high score
  String[] lines = loadStrings("highscore.txt"); // highscore saved in text file
if (lines.length > 0) {
  highScore = Integer.parseInt(lines[0]);
} else {
  // Handle the case where the file is empty or not present
  highScore = 0;
}
  
}

void draw() {
  
  if (currentPage == HOMEPAGE) { //if statement to display homepage
    homePage.display();
  } else if (currentPage == RULESPAGE) { //else if statement to rulespage 
    rulesPage.display();
  } else if (currentPage == PLAYING) {
    if (timerActive && millis() - startTime >= initialTime) {
      timerActive = true;  //else if statement to display gameover page when timer has run out
      currentPage = GAMEOVER;
      

      
    }
    if(currentPage == GAMEOVER) {
      currentPage = endPage.handleButtonClicks(); //when gameover page over, this is for the button logic
      endPage.display(score);
    }
    
  else {
      drawBackground();
      //countdown for game
      int remainingTime = max(0, (initialTime - (millis() - startTime) - (currentLevel - 1) * timeDecreaseRate) / 1000);
      //when timer = 0, game will call gameover page
      if (remainingTime == 0) {
        endPage.display(score);
       
      }
      // text to show timer for the game
      textSize(20);
      fill(255);
      textAlign(LEFT, TOP);
      text("Time: " + remainingTime + " seconds", 10, 10);


      // Update and render asteroids, check collisions with spaceship and astronaut
  for (Asteroid asteroid : asteroidList) {
    asteroid.update();
    asteroid.render();
    if (spaceship.checkCollision(asteroid)) {
      spaceship.handleCollision(asteroid);
    }
    if (astronaut.checkCollision(asteroid)) {
      astronaut.handleCollision(asteroid);
    }
  }

  // Update and check collisions for spaceships
  for (Spaceship spaceship : spaceshipList) {
    spaceship.update();
    for (Asteroid asteroid : asteroidList) {
      if (spaceship.checkCollision(asteroid)) {
        spaceship.handleCollision(asteroid);
      }
    }
  }

  // Update, render, and check collisions for astronauts
  for (Astronaut astronaut : astronautList) {
    astronaut.update();
    astronaut.render();
    for (Asteroid asteroid : asteroidList) {
      if (astronaut.checkCollision(asteroid)) {
        astronaut.handleCollision(asteroid);
      }
    }
    // Check collision with space station, update score, and add astronaut to removal list
    if (spacestation.checkCollision(astronaut)) {
      astronaut.handleCollision(spacestation);
      score += 10;
      astronautsToRemove.add(astronaut);
    }
  }

  // Update, check collisions, and handle removal for spaceships
  for (Spaceship spaceship : spaceshipList) {
    spaceship.update();
    for (Asteroid asteroid : asteroidList) {
      if (spaceship.checkCollision(asteroid)) {
        spaceship.handleCollision(asteroid);
      }
    }
    // Check collision with space station, update score, and add spaceship to removal list
    if (spacestation.checkCollision(spaceship)) {
      spaceship.handleCollision(spacestation);
      score += 10;
      spaceshipsToRemove.add(spaceship);
    }
  }

  // If no astronauts, spaceships, and asteroids left, progress to the next level
  if (astronautList.isEmpty() && spaceshipList.isEmpty() && asteroidList.isEmpty()) {
    currentLevel++;
    startTime = millis() - (currentLevel - 1) * timeDecreaseRate;
    initialTime = 20000;
  }

  // Update black hole, earth, and space station
  blackhole.update();
  earth.update();
  spacestation.update();

  // Check collisions and update score for asteroids near black hole
  for (int j = asteroidList.size() - 1; j >= 0; j--) {
    Asteroid currentAsteroid = asteroidList.get(j);
    currentAsteroid.update();
    if (blackhole.checkCollision(currentAsteroid)) {
      score += 10;
      asteroidList.remove(j);
    }
  }

  // Check collisions with space station and update score for spaceships
  for (int k = spaceshipList.size() - 1; k >= 0; k--) {
    Spaceship currentSpaceship = spaceshipList.get(k);
    currentSpaceship.update();
    if (spacestation.checkCollision(currentSpaceship)) {
      score += 10;
      spaceshipList.remove(k);
      spaceshipsToRemove.add(currentSpaceship);
    }
  }

  // Check collisions with space station and update score for astronauts
  for (int l = astronautList.size() - 1; l >= 0; l--) {
    Astronaut currentAstronaut = astronautList.get(l);
    currentAstronaut.update();
    if (spacestation.checkCollision(currentAstronaut)) {
      score += 10;
      astronautList.remove(l);
      astronautsToRemove.add(currentAstronaut);
    }
  }

  // Remove astronauts and spaceships marked for removal
  for (Astronaut astronaut : astronautsToRemove) {
    astronautList.remove(astronaut);
  }

  for (Spaceship spaceship : spaceshipsToRemove) {
    spaceshipList.remove(spaceship);
  }

  astronautsToRemove.clear();
  spaceshipsToRemove.clear();

  // Remove black hole if no asteroids are left
  if (asteroidList.isEmpty()) {
    blackhole.removed();
  }

  // Remove space station if no spaceships are left
  if (spaceshipList.isEmpty()) {
    spacestation.removed();
  }

  // Remove space station if no astronauts are left
  if (astronautList.isEmpty()) {
    spacestation.removed();
  }
  displayHighScore();
}
}

// Check if game over conditions are met based on the current level, astronauts, spaceships, and asteroids
if (currentLevel <= 3 && astronautList.isEmpty() && spaceshipList.isEmpty() && asteroidList.isEmpty()) {
  currentPage = GAMEOVER;
  timerActive = false;
  endPage.display(score);
} else if (currentLevel > 3 && astronautList.isEmpty() && !spaceshipList.isEmpty() && !asteroidList.isEmpty()) {
  currentPage = GAMEOVER;
  timerActive = false;

  // If the score is higher than the high score, update the high score
  if (score > highScore) {
    highScore = score;
    saveHighScore(highScore);
  }
}
}

// Display the high score on the screen
void displayHighScore() {
  textSize(20);
  fill(255);
  textAlign(CENTER, TOP);
  text("High Score: " + highScore, width / 2, 10);
}

// Save the new high score to a file
void saveHighScore(int newHighScore) {
  String[] lines = { str(newHighScore) };
  saveStrings("highscore.txt", lines);
}

// Load the high score from a file
int loadHighScore() {
  String[] data = loadStrings("highscore.txt");
  if (data.length > 0) {
    return int(data[0]);
  } else {
    return 0; // Return 0 if there's no high score saved
  }
}

// Handles mouse clicks based on the current game page
void mousePressed() {
  if (currentPage == HOMEPAGE) {
    currentPage = homePage.handleButtonClicks();
    if (currentPage == PLAYING) {
      timerActive = true;
      startTime = millis();
    }
  } else if (currentPage == RULESPAGE) {
    currentPage = rulesPage.handleButtonClicks();
  } else if (currentPage == GAMEOVER) {
    currentPage = endPage.handleButtonClicks();
  }
}
//calling the different pages
void initializePages() {
  homePage = new HomePage();
  rulesPage = new RulesPage();
  currentPage = HOMEPAGE;
  endPage = new EndPage();
}
//continues renders background image
void drawBackground() {
  image(backGround, 0, bgX);
  image(backGround, 0, bgX + backGround.height);

  bgX -= 1;
  if (bgX <= -backGround.height) {
    bgX = 0;
  }
}
// to load background image using png
//sizes backgroundimage to full canvas size
void loadBackgroundImage() {
  backGround = loadImage("spacebackground.png");
  backGround.resize(width, height);
}
// x, y for objects
void loadObjects() {
  blackhole = new Blackhole(0, 5);
  spacestation = new Spacestation(0, 3);
  earth = new Earth(10, 15);
  astronaut = new Astronaut(0, 3);
  spaceship = new Spaceship(0, 3);
}

void setupGame() {
  startTime = millis();  // Reset timer and initial time
  initialTime = 20000;  
}


void resetGameForNextLevel() {
  // Reset game elements based on the current level
  initializeGameElements();

  
  
}
void initializeHighScore() {
  highScore = loadHighScore(); // sets highscore on screen to newest highscore
}

void initializeGameElements() {
  // Initialize game elements based on the current level
  asteroidList.clear();
  spaceshipList.clear();
  astronautList.clear();
  
  // Only create asteroids in the first level
  if (currentLevel == 1) {
    for (int i = 0; i < 4; i++) {
      int randomA = (int) random(0, width);
      int randomB = (int) random(0, height - 300);
      asteroidList.add(new Asteroid(randomA, randomB));
    }
  }

  // Add spaceships and astronauts in subsequent levels
  if (currentLevel > 1) {
    for (int m = 0; m < 2; m++) {
      int randomX = (int) random(0, width);
      int randomY = (int) random(0, height);
      astronautList.add(new Astronaut(randomX, randomY));
    }
  }

  if (currentLevel > 2) {
    for (int m = 0; m < 2; m++) {
      int randomX = (int) random(0, width);
      int randomY = (int) random(0, height);
      spaceshipList.add(new Spaceship(randomX, randomY));
    }
  }
}

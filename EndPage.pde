class EndPage {
  String endMessage = "Game Over!"; // message on gameover page
  String scoreMessage = "Your final score: "; // message on gameover page
  int finalScore;
  boolean nextLevelButtonVisible = true;
  //int nextLevelButtonClickCount = 0;

  Button exitButton, nextLevelButton; //calling button logic from button class

  EndPage() {
    exitButton = new Button(width / 2 - 80, height / 2 + 100, 150, 70, "Exit"); // coordinates to display button
    nextLevelButton = new Button(width / 2 + 80, height / 2 + 100, 150, 70, "Next Level"); // coordinates to display button
  }

  void display(int finalScore) {
    this.finalScore = finalScore;
    background(0); //black background for gameover page
    if (nextLevelButtonVisible) {
      nextLevelButton = new Button(width / 2 + 80, height / 2 + 100, 150, 70, "Next Level");
    }

    textSize(40); // textsize
    fill(255); // White text
    textAlign(CENTER, CENTER); // alligns score in middle
    text(endMessage, width / 2, height / 2 - 50); // coordinates for end message 

    textSize(30);
    text(scoreMessage + finalScore, width / 2, height / 2 + 50); // coordinates for final score

    exitButton.display(); //displays exit button
    nextLevelButton.display();    //displays next level button
    handleButtonHover(exitButton); // when mouse hovers over button, button luminates
    handleButtonHover(nextLevelButton);// when mouse hovers over button, button luminates

  }

 int handleButtonClicks() {
  switch (currentPage) { //switch case
    case PLAYING: // when next level button is clicked, it goes to resetGameForNextLevel();
      if (nextLevelButton.isClicked(mouseX, mouseY)) {
        handleNextLevelButtonClick();
        return PLAYING; //returns to game where objects are reset
      }
      break; // if buttons not pressed stop game

    case GAMEOVER:
      if (nextLevelButton.isClicked(mouseX, mouseY)) {
        resetGameForNextLevel(); // when next level button is clicked, it goes to resetGameForNextLevel();
        return PLAYING;
      } else if (exitButton.isClicked(mouseX, mouseY)) {
        exit(); //if user wants to exit, press exit button or 'esc'
      }
      break; //if buttons not pressed stop game


    default://if buttons not pressed stop game
      break;
  }
  return GAMEOVER; // stays on gameover page if no buttons pressed
}

  void handleNextLevelButtonClick() {
     // when next level button is clicked, it goes to resetGameForNextLevel();
    resetGameForNextLevel();
  }

  void handleButtonHover(Button button) {
    if (button.isHovered(mouseX, mouseY)) {
      button.hover(); // handles the mouse logic when mouse is ontop of buttons
    } else {
      button.reset();
    }
  }

  void resetGameForNextLevel() {
    for (Floater asteroid : asteroidList) {
      asteroid.x = (int) random(0, width); // resets asteroids for next level
      asteroid.y = (int) random(0, height - 300);
    }

    for (Floater spaceship : spaceshipList) {
      spaceship.x = (int) random(0, width); // resets spaceships for next level
      spaceship.y = (int) random(0, height);
    }

    for (Floater astronaut : astronautList) {
      astronaut.x = (int) random(0, width); // resets astronauts for next level
      astronaut.y = (int) random(0, height);
    }

    spacestation.x = 0;
    spacestation.y = height - 365;

    blackhole.x = 0;
    blackhole.y = height - 165;

    earth.x = 10;
    earth.y = 15;

    currentPage = PLAYING;

    if (astronautList.isEmpty() && spaceshipList.isEmpty() && asteroidList.isEmpty()) {
      currentLevel++;
      startTime = millis() - (currentLevel - 1) * timeDecreaseRate;
      blackhole.reset();  // logic for when level has been completed, current level increases so timer restarts
      if (currentLevel > 1) {
        timerActive = true;
      }
    }

    int additionalAstronauts = 2 * currentLevel; // increases no. of astronauts for next level
    int additionalSpaceships = 2 * currentLevel; // increases no. of spaceships for next level
    int additionalAsteroids = 2 * currentLevel;// increases no. of asteroids for next level

    for (int i = 0; i < additionalAstronauts; i++) {
      astronautList.add(new Astronaut((int) random(0, width), (int) random(0, height))); 
    } //positon for astronauts to drop from
    

    for (int i = 0; i < additionalSpaceships; i++) {
      spaceshipList.add(new Spaceship((int) random(0, width), (int) random(0, height)));
    }

    for (int i = 0; i < additionalAsteroids; i++) {
      asteroidList.add(new Asteroid((int) random(0, width), (int) random(0, height - 300)));
    }
  }


}

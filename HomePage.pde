class HomePage {
  int numStars = 100; // Number of stars in the background
  Star[] stars = new Star[numStars]; // Array to store Star objects

  Button playButton, rulesButton, exitButton, nextLevelButton; // Buttons for different actions
  RulesPage rulesPage; // RulesPage object

  // Constructor method for HomePage
  HomePage() {
    // Initialize buttons and RulesPage
    playButton = new Button(width / 2, 200, 150, 70, "Play");
    rulesButton = new Button(width / 2, 300, 150, 70, "How to play");
    exitButton = new Button(width / 2, 400, 150, 70, "Exit");
    nextLevelButton = new Button(width / 2, 500, 150, 70, "Next Level");
    rulesPage = new RulesPage();

    // Initialize stars array with random Star objects
    for (int i = 0; i < numStars; i++) {
      stars[i] = new Star(random(width), random(height));
    }
  }

  // Method to handle button clicks and change game mode
  int handleButtonClicks() {
    if (currentPage == HOMEPAGE) {
      if (playButton.isClicked(mouseX, mouseY)) {
        return PLAYING;
      } else if (rulesButton.isClicked(mouseX, mouseY)) {
        return RULESPAGE;
      } else if (exitButton.isClicked(mouseX, mouseY)) {
        exitButton.onClick();
      } else if (nextLevelButton.isClicked(mouseX, mouseY)) {
        endPage.resetGameForNextLevel();
        nextLevel();
        return PLAYING;
      }

      return PLAYING;
    }

    return HOMEPAGE;
  }

  // Method to display the home page
  void display() {
    background(0);

    // Display stars in the background
    for (int i = 0; i < numStars; i++) {
      stars[i].floatAround();
      stars[i].followMouse(mouseX, mouseY);
      stars[i].display();
    }
    //Centering game title
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(120);
    text("Galactic Drift", width / 2, 100);

    // Display buttons based on the current game page
    if (currentPage == HOMEPAGE) {
      playButton.display();
      rulesButton.display();
      exitButton.display();

      // Handle button hover effects
      handleButtonHover(playButton);
      handleButtonHover(rulesButton);
      handleButtonHover(exitButton);
    } else if (currentPage == RULESPAGE) {
      rulesPage.display();
    }
  }

  // Method to handle mouse clicks using switch case
  void mousePressed() {
    switch (gameMode) {
      case HOMEPAGE:
        currentPage = handleButtonClicks();
        break;

      case PLAYING:
        timerActive = false;
        startTime = millis();
        break;

      case RULESPAGE:
        currentPage = rulesPage.handleButtonClicks();
        break;

      case GAMEOVER:
        currentPage = endPage.handleButtonClicks();
        break;

      // Add a default case if needed
      default:
        // Handle the case when gameMode is not any of the specified cases
        break;
    }
  }

  // Method to handle button hover effects
  void handleButtonHover(Button button) {
    if (button.isHovered(mouseX, mouseY)) {
      button.hover();
    } else {
      button.reset();
    }
  }

  // Method to progress to the next game level
  void nextLevel() {
    currentLevel++;
    score = 0;
    startTime = millis();
  }
}

class RulesPage {
  Button backButton; // Button to navigate back to the home page
  PImage background; // Background image for the rules page

  // Constructor for initializing the rules page with background image and back button
  RulesPage() {
    background = loadImage("spacebackground.png"); // Load background image
    backButton = new Button(width / 2, height - 50, 150, 50, "Back to Home"); // Create a back button centered at the bottom
  }

  // Display method to show the rules page content
  void display() {
    background(0); // Set background color

    // Display rules content using the background image
    imageMode(CORNER);
    image(background, 0, 0, width, height); // Display background image
    displayRulesText(); // Display the rules text

    backButton.display(); // Display the back button
    handleButtonHover(backButton); // Handle hover effects for the back button
  }

  // Display method for showing the rules text
  void displayRulesText() {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(255, 255, 0); // Set text color to yellow
    text("Rules:", width / 2, height / 3); // Display the title

    // Display individual rules with explanations
    text("-   Hover over while clicked and held to drag items", width / 2, height - 450);
    text("-   Collect all asteroids into the black hole to make it disappear and slow down other objects", width / 2, height - 400);
    text("-   Collect all astronauts/spaceships into the top left corner of the space station before the timer runs out to win", width / 2, height - 350);
    text("-   If you lose, images may still render for 5 seconds", width / 2, height - 300);
    text("-   Use 'Esc' to exit from the game", width / 2, height - 250);
    text("-   Easy enough? LET'S PLAY !! ↓", width / 2, height - 200);
  }

  // Method to handle button clicks and determine the next page
  int handleButtonClicks() {
    switch (RULESPAGE) {
      case RULESPAGE: // Check if the current page is the rules page
        if (backButton.isClicked(mouseX, mouseY)) {
          return HOMEPAGE; // Return to the home page if the back button is clicked
        }
        break;
    }
    return RULESPAGE; // Return the current page if no button is clicked
  }

  // Method to handle button hover effects
  void handleButtonHover(Button button) {
    if (button.isHovered(mouseX, mouseY)) {
      button.hover(); // Hover effect when the mouse is over the button
    } else {
      button.reset(); // Reset the button to its default state
    }
  }
}

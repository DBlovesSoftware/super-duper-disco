class Button {
  float x, y, w, h;
  String label;
  color baseColor, hoverColor, currentColor, textColor;
  float baseTextSize, hoverTextSize;

  // Constructor for the Button class
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.baseColor = color(30, 144, 255);
    this.hoverColor = color(70, 184, 255);
    this.currentColor = baseColor;
    this.textColor = color(255);
    this.baseTextSize = 20;
    this.hoverTextSize = 24;
  }

  // Display method to render the button on the screen
  void display() {
    rectMode(CENTER);
    fill(currentColor);
    rect(x, y, w, h);

    textAlign(CENTER, CENTER);
    textSize(baseTextSize);
    fill(textColor);
    text(label, x, y);
  }

  // Check if the mouse is hovering over the button
  boolean isHovered(float mx, float my) {
    return mx > x - w / 2 && mx < x + w / 2 && my > y - h / 2 && my < y + h / 2;
  }

  // Handle the button hover state
  void hover() {
    currentColor = hoverColor;
    textSize(hoverTextSize);
  }

  // Reset the button to its default state
  void reset() {
    currentColor = baseColor;
    textSize(baseTextSize);
  }

  // Check if the button is clicked
  boolean isClicked(float mx, float my) {
    return isHovered(mx, my);
  }

  // Handle the button click action
  void onClick() {
    // Perform different actions based on the button label
    if (label.equals("Exit")) {
      exit(); // Exit the application if the button is labeled "Exit"
    } else if (label.equals("Next Level")) {
      handleNextLevelClick(); // Handle the next level click action
    }
    
  }

  // Private method to handle the "Next Level" button click
  private void handleNextLevelClick() {
    currentLevel++;
    score = 0;
    startTime = millis();
  }
}

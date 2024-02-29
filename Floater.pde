class Floater {
  float wide = 200; // Width of the floater
  float dx, dy; // Variables for the change in x and y
  int clickX, clickY, x, y, xspeed, imgCounter, xPos, yPos, initialSpeed, localmouseX, localmouseY; // Various integer variables
  PImage[] images; // Array to store images
  boolean hold; // Boolean variable to track if the floater is being held/dragged

  // Constructor method
  Floater(int x, int y, String[] imageNames, int initialSpeed) {
    this.x = x;
    this.y = y;
    this.xspeed = initialSpeed;
    this.hold = false;
    this.imgCounter = 0;
    this.localmouseX = 0;
    this.localmouseY = 0;

    // Initialize the array of PImages
    images = new PImage[imageNames.length];
    for (int i = 0; i < imageNames.length; i++) {
      images[i] = loadImage(imageNames[i]);
    }
  }

  // Method to update mouse position
  void updateMouse() {
    localmouseX = mouseX;
    localmouseY = mouseY;
  }

  // Main update method
  void update() {
    render(); // Render the floater
    checkDrag(); // Check if the floater is being dragged
    move(); // Move the floater
    updateMouse(); // Update mouse position
  }

  // Placeholder method for moving logic
  void move() {
    // Your move logic goes here
  }

  // Render the floater
  void render() {
    image(images[imgCounter / 10 % images.length], x, y); // Display the current image
    imgCounter++;
  }

  // Check if the floater is being dragged
  void checkDrag() {
    float d = dist(localmouseX, localmouseY, x, y); // Calculate distance between mouse and floater
    if (!(this instanceof Blackhole) && !(this instanceof Spacestation) && !(this instanceof Earth)) {
      if (d < wide / 4 && d > -wide / 4) { //'this instanceof' used to test if object is an instance of a particular class
        if (mousePressed) {
          if (!hold) {
            hold = true; // When the mouse is held, objects can then be dragged
            clickX = localmouseX - x;
            clickY = localmouseY - y;
          }
        } else {
          hold = false; // If the mouse is not held, objects will not be dragged
        }
      }
    }
  //if held , objects will be dragged
    if (hold) {
      x = localmouseX - clickX;
      y = localmouseY - clickY;
    }
  }

  // Check if two floaters are colliding
  boolean checkCollision(Floater other) {
    float d = dist(x, y, other.x, other.y); // Calculate distance between this floater and another
    float minDist = wide / 6 + other.wide / 6; // Minimum distance for a collision
    return d < minDist;
  }

  // Handle collision between two floaters
  void handleCollision(Floater other) {
    float angle = atan2(other.y - y, other.x - x); // Calculate angle between floaters
    float moveAmount = (wide / 3 + other.wide / 3) / 2.0; // Calculate movement amount
    x -= cos(angle) * moveAmount; // Move in the x direction
    y -= sin(angle) * moveAmount; // Move in the y direction
    xPos = other.x; // Record the x position of the other floater
    yPos = other.y; // Record the y position of the other floater
  }
}

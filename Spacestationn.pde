
//Class Inheritance
class Spacestation extends Floater {
  boolean isActive; //boolean for when objects are moving
  
// Constructor - x, initialSpeed
  Spacestation(int x, int initialSpeed) {
    super(x, height-365, new String[]{"spacestation1.png"}, initialSpeed);
    
    isActive = true; // Set the space station to active initially
  }
  

  // sets movement logic across bottom of width.
  // Spacestation respawns when spacestation x-coordinate > width
  void move() {
    x += xspeed;
    if (x > width) {
      x = -images[0].width;
      println("Respawned");
    }
  }

  // Checks collision with Astronaut
  boolean checkAstronautCollision(Astronaut astronaut) {
    if (!isActive) {
      return false;
    }
    float distance = dist(x, y, astronaut.x, astronaut.y);
    return distance < (images[0].width + astronaut.wide) / 4;
  }

  // Checks collision with Spaceship
  boolean checkSpaceshipCollision(Spaceship spaceship) {
    if (!isActive) {
      return false;
    }
    float distance = dist(x, y, spaceship.x, spaceship.y);
    return distance < (images[0].width + spaceship.wide) / 4;
  }
  // if objects still active when timer = 0, isActive is true and set the isEmpty() off.
  void removed() {
    isActive = true;
  }
// Renders the spacestation if it's active
  void render() {
    if (isActive) {
      super.render();
    }
  }
}

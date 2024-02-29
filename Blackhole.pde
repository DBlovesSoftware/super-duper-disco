class Blackhole extends Floater {
  boolean isActive;

  Blackhole(int x, int initialSpeed) {
    super(x, height - 165, new String[]{"blackhole1.png", "blackhole2.png", "blackhole3.png", "blackhole4.png"}, initialSpeed);
    isActive = true;
  }

  // Resets the blackhole to its initial state
  void reset() {
    isActive = true;
    x = 0;
  }

  // Moves the blackhole across the bottom of the screen
  // Respawns when x-coordinate > width
  void move() {
    if (isActive) {
      x += xspeed;
      if (x > width) {
        respawn();
      }
    }
  }

  // Checks collision with an asteroid
  // Returns true if a collision occurs, otherwise false
  boolean checkCollision(Asteroid asteroid) {
    if (!isActive) {
      return false;
    }
    float distance = dist(x, y, asteroid.x, asteroid.y);
    return distance < (images[0].width + asteroid.wide) / 4;
  }

  // Deactivates the blackhole
  void removed() {
    isActive = false;
  }

  // Renders the blackhole if it's active
  void render() {
    if (isActive) {
      super.render();
    }
  }

  // Respawns the blackhole to the initial position
  private void respawn() {
    x = -images[0].width;
    println("Respawned");
  }
}

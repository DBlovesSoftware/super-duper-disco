class Spaceship extends Floater {
  //Constructor Method for spaceships
  Spaceship(int x, int y) {
    super(x, y, new String[]{"spaceship1.png"},0);
  }
   void move() {
    y -= random(-1.2, 0);
    // if asteroid goes off screen, reset the x to width
    if (y > height) {
      y = 0;
    }
  }
}

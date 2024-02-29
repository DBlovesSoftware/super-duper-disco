//Class Inheritance
class Asteroid extends Floater {
  //Constructor - x, y
  Asteroid(int x, int y) {
    super(x, y, new String[]{"asteroid1.png", "asteroid2.png", "asteroid3.png", "asteroid4.png"},0);
  }
   
 
  
   // sets movement logic across vertical distance of height.
  // Asteroid respawns when asteroids y-coordinate > height
  void move() {
    // yspeed of asteroid is 0 as they are stationary
    y -= random(-1, 0);
    if (y > height) {
      y = 0;
    }
  }
}

//Class Inheritance
class Astronaut extends Floater {
  //Constructor - x, y
  Astronaut(int x, int y) {
    super(x, y, new String[]{"astronaut1.png"},0);
    
  }
// sets movement logic across vertical distance of height.
  // Astronaut respawns when astronauts y-coordinate > height
  void move() {
    y -= random(-1.6,-0.2);
    if (y > height) {
      y = 0;
    }
  }
}
  

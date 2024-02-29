class Star {
  PImage sparkleImage;
  float x, y, movingX, movingY;
  float speed = 2;
  color starColor;
  //Constructor method for star class
  Star(float x, float y) {
    sparkleImage = loadImage("sparkle.png");
    this.x = x;
    this.y = y;
    starColor = color(random(200, 255), random(200, 255), random(200, 255));
    movingX = random(0, 1000);
    movingY = random(0, 1000);
  }

  void floatAround() {
    float moveX = noise(movingX); //noise() returns the value between 0 and 1 (creates smooth motion)
    float moveY = noise(movingY);

    x += map(moveX, 0, 1, -speed, speed); //move() remaps value from one range to another
    y += map(moveY, 0, 1, -speed, speed);
   
  }
    void followMouse(float targetX, float targetY) {
    float angle = atan2(targetY - y, targetX - x); //atan2() returns angle in radians betwwen positive x-axis and point of x,y
    x += cos(angle) * speed; //cos()returns cosine of angle given in radians
    y += sin(angle) * speed; //sin()returns cosine of angle given in radians
  }
  //displays the image with coordinates and size
  void display() {
    image(sparkleImage, x, y, 50, 50);
  }
}

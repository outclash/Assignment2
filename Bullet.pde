class Bullet 
{

  PVector pos;
  PVector MoveObj;
  float angle;
  int speed;
  int size;
  PImage[] img;
  
  Bullet()
  {
    
    img = new PImage[1];
    img[0] = loadImage("bullet.png");
    speed = 10;
    MoveObj = new PVector();
    pos = new PVector(0, 0);
    size = 10;
  
  }

  void drawBullet()
  {
    bulletfired();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    strokeWeight(5);
    image(img[0], 0, 0);
    popMatrix();
  }

  void bulletfired()
  {
    MoveObj.x = sin(angle);
    MoveObj.y =  -cos(angle);
    MoveObj.mult(speed);
    pos.add(MoveObj);
   
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      bullets.remove(this);
    }
  }
  

}
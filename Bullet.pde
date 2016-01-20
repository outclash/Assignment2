class Bullet 
{

  PVector pos;
  PVector MoveObj;
  float angle;
  int speed;
  int size;
  Bullet()
  {
    speed = 10;
    MoveObj = new PVector();
    pos = new PVector(0,0);
    size = 10;
  }

  void drawBullet()
  {
    bulletfired();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    strokeWeight(5);
    line(0, 0, 0, size);
    popMatrix();
  }

  void bulletfired()
  {
    MoveObj.x = sin(angle);
    MoveObj.y =  -cos(angle);
    MoveObj.mult(speed);
    pos.add(MoveObj);
  
    if (pos.x < 0 || pos.y < 14 || pos.x > width || pos.y > height)
    {
      bullets.remove(this);
    }
    
  }
}
class Bullet 
{
  
  PVector pos;
  float angle1;
  int speed;
    PVector forward;
  Bullet(int x, int y, float angle)
  {
   pos = new PVector(x,y);
   angle1 = angle;
   speed = 10;
   forward = new PVector(0, -1);
  }
  
  void drawBullet()
  {
   
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle1);
    line(0,0,0,-10);
    popMatrix();
     
println(angle1,pos.x,pos.y);
  }
  
  void bulletfired()
  {
    forward.x = sin(angle1);
    forward.y =  -cos(angle1);
      
    forward.mult(speed);
    pos.add(forward);
    
  }
}
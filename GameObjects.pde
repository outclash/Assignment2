abstract class GameObjects
{
  int lives;
  float x, y;
  float angle;
  float speed;
  PVector pos;
  PVector MoveObj;
  PImage[] img;
  boolean spawn;

  GameObjects()
  {
    x = width/2;
    y = 475;
    angle = 0;
    speed = 0;
    spawn = true;
    pos = new PVector(x, y);
    MoveObj = new PVector(0, 0);
  }
  
  abstract void update();  
  abstract void render();
  
}
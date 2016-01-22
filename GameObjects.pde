class GameObjects
{
  float x, y;
  float angle;
  float speed;
  PVector pos;
  PVector MoveObj;
  PImage[] img;
  boolean spawn;
  AudioPlayer[] audio;

  GameObjects()
  {
    x = width/2;
    y = 475;
    angle = 0;
    speed = 0;
    spawn = true;
    pos = new PVector(x, y);
    MoveObj = new PVector(0, 0);
    audio = new AudioPlayer[5];
  }
}
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
    spawn = false;
    pos = new PVector(x, y);
    MoveObj = new PVector(0, 0);
    audio = new AudioPlayer[5];

    //audio[0] = minim.loadFile("Sound/TankFiring-SoundBible.com-998264747.wav");
    // audio[1] = minim.loadFile("Sound/Zombie Moan-SoundBible.com-565291980.wav");
  }
}
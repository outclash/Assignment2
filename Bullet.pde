class Bullet extends GameObjects
{
  int size;

  Bullet()
  {  
    audio[0] = minim.loadFile("Sound/TankFiring-SoundBible.com-998264747.wav");

    img = new PImage[1];
    img[0] = loadImage("bullet.png");
    speed = 10;
    pos = new PVector(0, 0);
    size = 10;
  }

  void drawBullet()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    strokeWeight(5);
    image(img[0], -img[0].width/2, -img[0].height/2);
    popMatrix();

    bulletfired();
  }

  void bulletfired()
  {
    MoveObj.x = sin(angle);
    MoveObj.y = -cos(angle);
    MoveObj.mult(speed);
    pos.add(MoveObj);
    
    //bullet spawn/fired
    if (spawn)
    {
      audio[0].rewind();
      audio[0].play();
      spawn = false;
    }
    
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      bullets.remove(this);
    }
  }
}
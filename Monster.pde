class Monster extends GameObjects
{
  int size;
  float bonus;
  int zomScore;
  PImage[][] zomMove;
  float changeFrame;

  Monster()
  {
    changeFrame = 0;
    speed=random(0, 0.2);
    size = 15;
    zomScore = 10;
    bonus = speed * 10;
    pos = new PVector(random(10, 490), 0);

    audio[0] = minim.loadFile("Sound/Zombie Moan-SoundBible.com-565291980.wav");

    img = new PImage[1];
    zomMove = new PImage[1][3];
    img[0] = loadImage("Zombies/5ZombieSpriteSheet1.png");

    //Cutting Images
    for (int i = 0; i < 2; i++)
    {
      zomMove[0][i] = img[0].get( 0 + (32 * i), 0, 32, 34);
    }
  }

  void drawMonster()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(angle);
    image (zomMove[0][(int)changeFrame], -zomMove[0][0].width, -zomMove[0][0].height);
    popMatrix();

    moveMonster();
  }

  void moveMonster()
  {
    changeFrame = (changeFrame + .05) % 2;
    if (changeFrame > 2 )
    {
      changeFrame = 0;
    }

    pos.add(0, speed);

    if (spawn)
    {
      audio[0].rewind();
      audio[0].play();
      spawn = false;
    }

    if (pos.y > height)
    {
      monsters.remove(this);
    }
  }
}
class Monster extends GameObjects
{
  int size;
  float bonus;
  int zomScore;
  PImage[][] zomMove;
  float changeFrame;

  Monster()
  {
    lives = 1;
    if (nextlvl == 2)
    {
      lives = (int)random(1, 3);
    }

    img = new PImage[1];
    zomMove = new PImage[1][3];
    img[0] = loadImage("Zombies/5ZombieSpriteSheet1.png");

    //Cutting Images
    for (int i = 0; i < 2; i++)
    {
      zomMove[0][i] = img[0].get( 0 + (32 * i), 0, 32, 34);
    }

    changeFrame = 0;
    speed=random(0, 0.7);
    size = 15;
    zomScore = 10;
    bonus = speed * 10;
    pos = new PVector(random(zomMove[0][0].width/2, width - zomMove[0][0].width/2), 0);
  }

  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    image (zomMove[0][(int)changeFrame], -zomMove[0][0].width/2, -zomMove[0][0].height/2);
    text(lives, 0, zomMove[0][0].height/2);
    popMatrix();

    update();
  }

  void update()
  {  
    //animation frames rotation
    changeFrame = (changeFrame + .05) % 2;
    if (changeFrame > 2 )
    {
      changeFrame = 0;
    }

    pos.add(0, speed);
  }
}
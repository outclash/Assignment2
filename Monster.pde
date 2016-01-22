class Monster
{
  PVector pos;
  
  float speed;
  int size;
  //int angle;
  //int spawnTime;
  float bonus;
  int score;
  PImage zom;
  PImage[][] zomMove;
  float changeFrame;

  Monster()
  {
    zomMove = new PImage[1][3];
    zom = loadImage("Zombies/5ZombieSpriteSheet1.png");
    for (int i = 0; i < 2; i++)
    {
      zomMove[0][i] = zom.get( 0 + (32 * i), 0, 32, 34);
    }
    changeFrame=0;
    
    pos = new PVector(random(10, 490), 0);
   
    speed=random(0, 0.2);
    size = 15;
    score = 10;
    bonus= speed * 10;
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
    changeFrame = (changeFrame + .05) % 2 ;
    if (changeFrame > 2 )
    {
      changeFrame=0;
    }
   
    pos.add(0, speed);

    if (pos.y > height)
    {
      monsters.remove(this);
    }
  }
}
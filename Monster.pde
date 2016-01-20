class Monster
{
  PVector pos;
  float speed;
  int size;
  int spawnTime;
  float bonus;
  int score;
  Monster()
  {
    pos = new PVector(random(10, 490), 0);
    speed=random(0,2);
    size = 15;
    score = 10;
    bonus= speed * 10;
  }

  void drawMonster()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(angle);
    ellipse(0, 0,size, size );
    popMatrix();

    moveMonster();
  }

  void moveMonster()
  {
    pos.add(0, speed);
    if(pos.y > height)
    {
      monsters.remove(this); 
    }
    
  }
}
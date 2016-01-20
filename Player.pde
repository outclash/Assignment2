class Player
{
  int x;
  int y;
  int x2;
  int y2;
  float angle;
  int bulletInterval;

  Player()
  {
    x = width/2;
    y = 475;
    x2 = width/2;
    y2 = 425;
    angle = 0;
    bulletInterval = 35;
  }

  void drawPlayer()
  {
    movePlayer();
    stroke(255, 255, 0);
    strokeWeight(1);
    ellipse(x, y, 80, 50);
   
    pushMatrix();
    translate(x, y);
    rotate(angle);
    stroke(122);
    line(0, 0, angle, -700);
    stroke(255, 0, 0);
    rect(5, 5, -10, -50);
    popMatrix();
  }

  void movePlayer()
  {
    if (keys['A'])
    {
      x-=3;
    } 
    if (keys['D'])
    {
      x+=3;
    }

    if (keys['J'])
    {
      angle -= 0.01;
    } 
    if (keys['K'])
    {
      angle += 0.01;
    }

    if (keys[' '] && bulletInterval > 35)
    {
      Bullet bullet = new Bullet();
      bullet.pos.x = x;
      bullet.pos.y = y;
      bullet.angle = angle;
      bullets.add(bullet);
      bulletInterval = 0;
    }

    bulletInterval++;

    if (x>width-40)
    {
      x=width-40;
    }
    if (x<40)
    {
      x=40;
    }

   // println(angle);
    if (angle > 1.5)
    {
      angle=1.5;
    }
    if (angle < -1.5 )
    {
      angle= -1.5;
    }
  }
}
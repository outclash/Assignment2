class Player
{
  int x;
  int y;
  int x2;
  int y2;
  float angle;
  Player()
  {
    x = width/2;
    y = 475;
    x2 = width/2;
    y2 = 425;
    angle = 0;
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
    stroke(255, 0, 0);
    rect(5, 5, -10, -50);
    popMatrix();
  }

  void movePlayer()
  {
    if (keys['A'])
    {
      x--;
    } 
    if (keys['D'])
    {
      x++;
    }

    if (keys['J'])
    {
      angle -= 0.05;
    } 
    if (keys['K'])
    {
      angle += 0.05;
    }

    if (x>width-40)
    {
      x=width-40;
    }
    if (x<40)
    {
      x=40;
    }
  }
}
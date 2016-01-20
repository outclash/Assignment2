class Player
{
  PVector pos;
  float angle;
  int bulletInterval;
  PImage[] img = new PImage[2];
  
  Player()
  {
    pos = new PVector(width/2,475);
    img[0] = loadImage("body.png");
    img[1] = loadImage("weapon.png");
    angle = 0;
    bulletInterval = 35;
  }

  void drawPlayer()
  {
    movePlayer();
    image(img[0],pos.x-img[0].width/2,pos.y-img[0].height/2); 
   
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    stroke(122);
    strokeWeight(1);
    line(0, 0, angle, -700);
    
     image(img[1],-img[1].width/2,-img[1].height+20);
    popMatrix();
  }

  void movePlayer()
  {
    if (keys['A'])
    {
      pos.x-=3;
    } 
    if (keys['D'])
    {
      pos.x+=3;
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
      bullet.pos.x = pos.x;
      bullet.pos.y = pos.y;
      bullet.angle = angle;
      bullets.add(bullet);
      bulletInterval = 0;
    }

    bulletInterval++;

    if (pos.x>width-40)
    {
      pos.x=width-40;
    }
    if (pos.x<40)
    {
      pos.x=40;
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
class Player extends GameObjects
{
  int bulletInterval;
  int fireguideline;

  Player()
  {
    speed = 3;
    bulletInterval = 35;
    fireguideline = -1000;

    img = new PImage[2];
    img[0] = loadImage("body.png");
    img[1] = loadImage("weapon.png");
  }

  void drawPlayer()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    stroke(122);
    strokeWeight(1);
    image(img[0], -img[0].width/2, -img[0].height/2); 
    line(0, 0, angle, fireguideline);
    image(img[1], -img[1].width/2, -img[1].height+20);
    popMatrix();

    movePlayer();
  }

  void movePlayer()
  {
    if (keys['A'])
    {
      pos.x -= speed;
    }

    if (keys['D'])
    {
      pos.x += speed;
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

    if (pos.x > width - 40)
    {
      pos.x = width - 40;
    }
    if (pos.x < 40)
    {
      pos.x = 40;
    }

    // println(angle);
    if (angle > 1.5)
    {
      angle = 1.5;
    }
    if (angle < -1.5 )
    {
      angle = -1.5;
    }
  }
}
Player player;
Bullet bullet;

void setup()
{
  size(500, 500);
  player = new Player();
  bullet = new Bullet(250,475,0);
     
} 

void draw()
{
  background(0);
  player.drawPlayer();
   bullet.bulletfired();
   bullet.drawBullet();
 
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}
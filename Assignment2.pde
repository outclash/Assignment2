Player player;

void setup()
{
  size(500, 500);
  player = new Player();
} 

void draw()
{
  background(0);
  player.drawPlayer();
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
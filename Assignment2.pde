Player player;

void setup()
{
  size(500, 500);
  player = new Player();
} 
int numMonster=10;

void draw()
{
  background(0);
  player.drawPlayer();

  addmonsters();

  for (int i = bullets.size() - 1; i >= 0; i --)
  {
    bullets.get(i).drawBullet();
  }

  collision();

  text("Score: " + score, 10, 30 );
}

int score;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Monster> monsters = new ArrayList<Monster>();

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}


void addmonsters()
{
  for (int i =0; i<numMonster; i++)
  {
    monsters.add(new Monster());

    if (monsters.size() == numMonster)
    {
      numMonster=0;
    }
  }
  for (int i =monsters.size() -1; i>=0; i--)
  {
    monsters.get(i).drawMonster();
  }

  if (monsters.size() == 0)
  {
    numMonster=10;
  }
}


void collision()
{
  for (int i = bullets.size() - 1; i >= 0; i --)
  {
    Bullet B = bullets.get(i);
    for (int j = monsters.size() - 1; j >= 0; j --)
    {
      Monster M = monsters.get(j);

      // Bounding circle collisions
      if (B.pos.dist(M.pos) < B.size/2 + M.size/2)
      {
        monsters.remove(M);
        bullets.remove(B);
        score = (int)M.bonus + M.score + score;
      }
    }
  }
}
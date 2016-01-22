import ddf.minim.*;
Minim minim;
Player player;
int numMonster=10;
int score;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Monster> monsters = new ArrayList<Monster>();
boolean[] keys = new boolean[512];
AudioPlayer[] audio;

void setup()
{
  size(500, 500);
  minim = new Minim(this);
  player = new Player();
  audio = new AudioPlayer[5];
  audio[0] = minim.loadFile("Sound/Zombie Gets Attacked-SoundBible.com-20348330.wav");
} 

void draw()
{
  background(0);

  player.drawPlayer();

  for (int i = bullets.size() - 1; i >= 0; i --)
  {
    bullets.get(i).drawBullet();
  }

  addmonsters();

  collision();

  text("Score: " + score, 10, 30 );
}

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
  for (int i = 0; i < numMonster; i++)
  {
    monsters.add(new Monster());

    if (monsters.size() == numMonster)
    {
      numMonster = 0;
    }
  }
  for (int i = monsters.size() -1; i >= 0; i--)
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

      if (B.pos.dist(M.pos) < (B.size) + M.size)
      {
        println(dist(B.pos.x, B.pos.y, M.pos.x, M.pos.y), (B.size/2) + M.size/2);
        monsters.remove(M);
        bullets.remove(B);
        audio[0].rewind();
        audio[0].play();
        score = (int)M.bonus + M.zomScore + score;
      }
    }
  }
}
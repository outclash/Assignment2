import ddf.minim.*;
Minim minim;
Player player;
int numMonster=10;
int score;
int cenX, cenY;
PImage[] menu = new PImage[4];
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Monster> monsters = new ArrayList<Monster>();
boolean play = false;
boolean exit = false;
boolean[] keys = new boolean[512];
AudioPlayer[] audio;

void setup()
{
  size(500, 550);
  cenX = width/2;
  cenY = height/2;
  minim = new Minim(this);
  player = new Player();
  audio = new AudioPlayer[5];
  audio[0] = minim.loadFile("Sound/Zombie Gets Attacked-SoundBible.com-20348330.wav");
  menu[0] = loadImage("Gamemenu.png");
  for (int i = 1; i < 4; i++)
  {
    menu[i] = menu[0].get(0, 0 + (40 * (i-1)), 80, 40  );
  }
} 

void draw()
{
  background(0);

  if (!play)
  {
    tint(255, 126);
    image(menu[1], cenX -menu[1].width/2, cenY -50 -menu[1].height/2);
    image(menu[2], cenX -menu[2].width/2, cenY  -menu[1].height/2);

    if (mouseX > cenX -menu[1].width/2 &&
      mouseY > cenY -50 -menu[1].height/2 &&
      mouseX < cenX -menu[1].width/2 + menu[1].width &&
      mouseY < cenY -50 -menu[1].height/2 + menu[1].height || keys['P'])
    {
      noTint();
      image(menu[1], cenX -menu[1].width/2, cenY -50 -menu[1].height/2);
      if (mousePressed || keys['P'])
      {
        play = true;
      }
    } 

    if (mouseX > cenX -menu[2].width/2 &&
      mouseY > cenY -menu[2].height/2 &&
      mouseX < cenX -menu[2].width/2 + menu[2].width &&
      mouseY < cenY -menu[2].height/2 + menu[2].height)
    {
      noTint();
      image(menu[2], cenX -menu[2].width/2, cenY  -menu[1].height/2);
      if (mousePressed)
      {
        exit = true;
      }
    }
  }

  if (exit)
  {
    exit();
  }

  if (play)
  {
    tint(255, 126);
    image(menu[3], 400, 523, menu[2].width, 25);
    if (mouseX > 400 &&
      mouseY > 523 &&
      mouseX < 400 + menu[2].width &&
      mouseY < 523 + 25 || keys['M'])
    {
      noTint();
      image(menu[3], 400, 523, menu[2].width, 25);
      if (mousePressed || keys['M'])
      {
        play = false;
      }
    }

    noTint();
    stroke(255);
    line(0, 520, 500, 520);

    player.drawPlayer();
    for (int i = bullets.size() - 1; i >= 0; i --)
    {
      bullets.get(i).drawBullet();
    }
    addmonsters();
    collision();
    text("Score: " + score, 10, 540 );
  }
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

      // if (dist(B.pos.x, B.pos.y, M.pos.x, M.pos.y) < (B.img[0].width/5 + B.img[0].height/5) + (M.zomMove[0][0].width/5 + M.zomMove[0][0].height/5))
      if (abs(B.pos.x + B.img[0].width/2) >= abs(M.pos.x) &&
        abs(B.pos.x) <= abs(M.pos.x + M.zomMove[0][0].width/2) &&
        abs(B.pos.y + B.img[0].height/2) >= abs(M.pos.y) &&
        abs(B.pos.y) <= abs(M.pos.y + M.zomMove[0][0].height/2)
        )
      {
        //M.pos.y(B.size/2) + M.size/2
        // println(B.pos.dist(M.pos), dist(B.pos.x, B.pos.y, M.pos.x, M.pos.y), B.pos.x, B.pos.y, M.pos.x, M.pos.y, 
        //(B.img[0].width/5 + B.img[0].height/5) + (M.zomMove[0][0].width/5 + M.zomMove[0][0].height/5));
        monsters.remove(M);
        bullets.remove(B);
        audio[0].rewind();
        audio[0].play();
        score = (int)M.bonus + M.zomScore + score;
      }
    }
  }
}
import ddf.minim.*;
Minim minim;
Player player;
//int numMonster=10;
int score;
int[] lvl = {15, 30, 70};
int nextlvl;
int gameComplete;
int cenX, cenY;
PImage[] menu = new PImage[4];
PImage bg;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Monster> monsters = new ArrayList<Monster>();
boolean play = false;
boolean exit = false;
boolean lvlclear = false;
boolean[] keys = new boolean[512];
AudioPlayer[] audio;

void setup()
{
  size(500, 550);
  nextlvl = 0;
  gameComplete = 0;
  cenX = width/2;
  cenY = height/2;
  minim = new Minim(this);
  player = new Player();
  audio = new AudioPlayer[5];
  audio[0] = minim.loadFile("Sound/Zombie Gets Attacked-SoundBible.com-20348330.wav");
  bg = loadImage("6dbfe6d75bf2051b5cf5e3079ce89f8d copy.png");
  bg.resize(width, height);
  menu[0] = loadImage("Gamemenu.png");
  for (int i = 1; i < 4; i++)
  {
    menu[i] = menu[0].get(0, 0 + (40 * (i-1)), 80, 40  );
  }
} 

void draw()
{
  background(bg);

  if (!play)
  {
    tint(255, 126);
    image(menu[1], cenX -menu[1].width/2, cenY -50 -menu[1].height/2);
    image(menu[2], cenX -menu[2].width/2, cenY  -menu[1].height/2);

    if (mouseX > cenX -menu[1].width/2 &&
      mouseY > cenY -50 -menu[1].height/2 &&
      mouseX < cenX -menu[1].width/2 + menu[1].width &&
      mouseY < cenY -50 -menu[1].height/2 + menu[1].height 
      || keys['P'])
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
      mouseY < cenY -menu[2].height/2 + menu[2].height 
      || keys['E'])
    {
      noTint();
      image(menu[2], cenX -menu[2].width/2, cenY  -menu[1].height/2);
      if (mousePressed || keys['E'])
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
      mouseY < 523 + 25 
      || keys['M'])
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
  if (gameComplete != lvl.length)
  {
    for (int i = 0; i < lvl[nextlvl]; i++)
    {
      monsters.add(new Monster());

      if (monsters.size() == lvl[nextlvl])
      {
        lvl[nextlvl] = 0;
      }
    }
    for (int i = monsters.size() -1; i >= 0; i--)
    {
      monsters.get(i).drawMonster();
    }

    if (monsters.size() == 0)
    {
      lvlclear = true;
    }

    if (lvlclear)
    {
      nextlvl++;
      gameComplete++;
      lvlclear = false;
    }
  } else 
  {
    text("Congratulations", width/2, height/2);
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

      if (abs(B.pos.x + B.img[0].width) >= abs(M.pos.x) &&
        abs(B.pos.x) <= abs(M.pos.x + M.zomMove[0][0].width) &&
        abs(B.pos.y + B.img[0].height) >= abs(M.pos.y) &&
        abs(B.pos.y) <= abs(M.pos.y + M.zomMove[0][0].height)
        )
      {
        monsters.remove(M);
        bullets.remove(B);
        audio[0].rewind();
        audio[0].play();
        score = (int)M.bonus + M.zomScore + score;
      }
    }
  }
}
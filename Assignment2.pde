import ddf.minim.*;
Minim minim;

int score;
//number of monsters per level
int[] lvl = {15, 30, 50};
int nextlvl;
int gameComplete;
int cenX, cenY;
int monNum;
int spawntime;

PImage[] menu = new PImage[4];
PImage bg;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Monster> monsters = new ArrayList<Monster>();
ArrayList<Player> player = new ArrayList<Player>();

boolean play = false;
boolean exit = false;
boolean lvlclear = false;
boolean allspawned = false;
boolean[] keys = new boolean[512];

AudioPlayer[] audio;

//initialising
void setup()
{
  size(500, 550);
  nextlvl = 0;
  gameComplete = 0;
  cenX = width/2;
  cenY = height/2;
  monNum = 0;
  spawntime = 60;

  minim = new Minim(this);

  player.add(new Player());

  //load audio once
  audio = new AudioPlayer[5];
  audio[0] = minim.loadFile("Sound/TankFiring-SoundBible.com-998264747.wav");
  audio[1] = minim.loadFile("Sound/Zombie Moan-SoundBible.com-565291980.wav");
  audio[3] = minim.loadFile("Sound/Zombie Gets Attacked-SoundBible.com-20348330.wav");

  //load background and menu images
  bg = loadImage("6dbfe6d75bf2051b5cf5e3079ce89f8d copy.png");
  bg.resize(width, height);
  menu[0] = loadImage("Gamemenu.png"); //loading the image contains play,exit,menu = menu[1],menu[2],menu[3] respectively
  for (int i = 1; i < 4; i++)
  {
    menu[i] = menu[0].get(0, 0 + (40 * (i-1)), 80, 40  );
  }
} 

void draw()
{
  background(bg);

  //Game menu options
  gameMenu();

  if (play)
  {
    if (frameCount < 420)
    {
      textSize(15);
      text("Shoot all monsters and \ndont let them pass the border!\n\nUse A and D to move left or right\nJ and K to move guide line left or right\nSpace to shoot ", 90, 200);
    }

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

    player.get(0).render();

    for (int i = bullets.size() - 1; i >= 0; i --)
    {
      bullets.get(i).render();
    }
    addmonsters();
    collision();
    textSize(10);
    text("Score: " + score, 10, 540 );
    text("Level: "  + (nextlvl + 1), 300, 540);
  }

  //player is dead
  if (player.get(0).lives <= 0)
  {
    player.get(0).lives = 0;
    gameComplete = 3;
    textSize(30);
    text("You lose!!!", width/2 - 100, height/2 -100 );
    noLoop();
  }

  //if game complete equals all level is cleared 
  if (gameComplete == lvl.length) 
  {
    textSize(30);
    text("Total Score: " + score, width/2 - 100, height/2);
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

void gameMenu()
{
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
}

//spawning monsters and completing the level
void addmonsters()
{
  if (gameComplete != lvl.length)
  {
    //spawn monster every spawntime 60 = 1 second...
    if (frameCount % spawntime == 0 &&  monNum < lvl[nextlvl] )
    {
      //monster sound in the start
      if (monNum == 0)
      {
        audio[1].rewind();
        audio[1].play();
      }

      monsters.add(new Monster());
      monNum++;

      if (monNum == lvl[nextlvl])
      {
        allspawned = true;
      }
    }

    for (int i = monsters.size() -1; i >= 0; i--)
    {
      monsters.get(i).render();
    }

    if (monsters.size() == 0 && allspawned) 
    {
      allspawned = false;
      lvlclear = true;
      if (lvlclear)
      {
        gameComplete++;
        monNum = 0;
        nextlvl++;
        spawntime -= 10;
        lvlclear = false;
      }
    }
  }
}


void collision()
{
  for (int i = monsters.size() - 1; i >= 0; i --)
  {
    Monster M = monsters.get(i);

    //collision between monster and border
    if (M.pos.y > height - 50)
    {
      player.get(0).lives -= M.lives;
      monsters.remove(M);
    }

    for (int j = bullets.size() - 1; j >= 0; j --)
    {
      Bullet B = bullets.get(j);

      //collision checking for bullet and monsters
      //rectangle collision algorithm
      if (abs(B.pos.x + B.img[0].width) >= abs(M.pos.x) &&
        abs(B.pos.x) <= abs(M.pos.x + M.zomMove[0][0].width) &&
        abs(B.pos.y + B.img[0].height) >= abs(M.pos.y) &&
        abs(B.pos.y) <= abs(M.pos.y + M.zomMove[0][0].height)
        )
      {
        bullets.remove(B);
        M.lives--;

        if (M.lives == 0)
        {
          monsters.remove(M);
          audio[3].rewind();
          audio[3].play();
        }

        score = (int)M.bonus + M.zomScore + score;
      }
    }
  }
}
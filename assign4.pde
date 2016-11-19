//You should implement your assign4 here.
PImage bg1, bg2, bg3, bg4, enemy, fighter, hp, treasure, start1, start2, end1, end2,flame1,flame2,flame3,flame4,flame5,shoot;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2; 

int gameState;
int x;
int blood;
int treasureX, treasureY;
int speedEnemyX=5, speedEnemyY,enemyDefaultX, enemyDefaultY;
int fighterX, fighterY;
int speedFighter = 5;
int spacing = 60;
int speedBullet = 8;
int Num;
float disappear;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
String ENEMY_STYLE;
float[] enemy1X = new float[5];
float[] enemy1Y = new float[5];
float[] enemy2X = new float[5];
float[] enemy2Y = new float[5];
float[] enemy3X = new float[8];
float[] enemy3Y = new float[8];
boolean[] bulletNum = new boolean[5];
float[] bulletX = new float[5];
float[] bulletY = new float[5];
PImage[] flame = new PImage[5];  

void setup () {
  size(640, 480);
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  bg3 = loadImage("img/bg1.png");
  bg4 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  for(int i=0;i<5;i++){
    flame[i] = loadImage("img/flame"+(i+1)+".png");
  }
  shoot = loadImage("img/shoot.png");
  
  //background
  image(bg2,0,0,640,480);
  
  //blood
  blood = (200/100)*20;
  
  //random treasure position  
  treasureX = floor(random(50,590));
  treasureY = floor(random(50,430));
  
  //random enemy height
  enemy1X[0]=0;
  enemyDefaultY = floor(random(50,420));
  
  //bullet
   for (int i =0;i<bulletNum.length;i ++){
    bulletNum[i] = false;
  }
  
  //fighter position
  fighterX = width-50;
  fighterY = floor(random(50,430));
  
  gameState = GAME_START;
  ENEMY_STYLE = "c";
}

void draw() {
  switch(gameState){
    case GAME_START:
      image(start2,0,0,640,480);
      if(mouseX>=150 && mouseX<=450 && mouseY>=350 && mouseY<=430){
        image(start1,0,0,640,480);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }
      break;
    case GAME_RUN:
      //background roll
      if(640+x%1280>640){
        image(bg1,-1280,0,640,480);
      }
      if(0+x%1280>640){
        image(bg2,-1280,0,640,480);
      }
      if(1280+x%1280>640){
        image(bg3,-1280,0,640,480);
      }
      if(-1280+x%1280>640){
        image(bg4,-1280,0,640,480);
      }
      image(bg1,640+x%1280,0,640,480);
      image(bg2,0+x%1280,0,640,480);
      image(bg3,-640+x%1280,0,640,480);
      image(bg4,-1280+x%1280,0,640,480);
      x+=4;     
      
      
      //blood
      noStroke();
      fill(255,0,0);
      rect(10,5,blood,20);
      
      //hp
      image(hp,1,0);
      
      //treausre
      if(((treasureX-30<=fighterX) && (fighterX<=treasureX+30))&&(treasureY-30<=fighterY)&&(fighterY<=treasureY+30)){
        blood +=(200/100)*10;
        if(blood>(200/100)*100){
           blood = (200/100)*100;
         }
        treasureX = floor(random(50,590));
        treasureY = floor(random(50,430));
      }
      image(treasure,treasureX,treasureY);
      
      //bullet
       if(keyCode==' '){
            if (bulletNum[Num] == false){
              bulletNum[Num] = true;
              bulletX[Num] = fighterX-30;
              bulletY[Num] = fighterY+15;
              Num++;
            }   
            if (Num>4) {
              Num = 0;
            }
        }
      for (int i=0;i<Num;i++){
        if (bulletNum[i] == true){
          image (shoot, bulletX[i], bulletY[i]);
        }
        bulletX[i]-=speedBullet;
        if (bulletX[i] < -width){
          bulletNum[i] = false;
        }
      }
            
      
      //enemy assign 4
      switch (ENEMY_STYLE){
        case "c":
          if(enemy1X[0]-4*spacing>=640){
              enemy1X[0]=0;
              enemyDefaultY = floor(random(50,420-4*spacing));
              ENEMY_STYLE = "b";
            }else{
              enemy1X[0]+=speedEnemyX;
              for(int i=0;i<enemy1X.length;i++){  
                enemy1X[i]=enemy1X[0]-spacing*i;
                enemy1Y[i]=enemyDefaultY;
                if((enemy1X[i]-30<=fighterX) && (fighterX<=enemy1X[i]+30) && (enemy1Y[i]-30<=fighterY) && (fighterY<=enemy1Y[i]+30)){
                  blood -=(200/100)*20;
                  disappear = enemy1X[i]+1000;               
                  image(enemy,disappear,enemy1Y[i]+1000);
                  for(int j=0;j<flame.length;j++){
                      image(flame[j],enemy1X[i],enemy1Y[i]);
                      frameRate(100);
                      }
                     if(blood<=0){
                        gameState = GAME_LOSE;
                       }
                  }
                  for(int j=0;j<Num;j++){
                    if((enemy1X[i]-30<=bulletX[j]) && (bulletX[i]<=enemy1X[i]+30) && (enemy1Y[i]-30<=bulletY[i]) && (bulletY[i]<=enemy1Y[i]+30)){
                      disappear = enemy1X[i]+1000; 
                      image(enemy,disappear,enemy1Y[i]+1000);
                      for(int k=0;k<flame.length;k++){
                        image(flame[k],enemy1X[i],enemy1Y[i]);
                        frameRate(100);
                        }
                        bulletNum[j] = false;
                    }
                  }
                image(enemy,enemy1X[i],enemy1Y[i]);              
              }
           }           
          break;
        case "b":
          if(enemy2X[0]-4*spacing>=640){
              enemy2X[0]=0;
              enemyDefaultY = floor(random(50+2*spacing,420-2*spacing));
              ENEMY_STYLE = "a";
            }else{
              enemy2X[0]+=speedEnemyX;
              for(int i=0;i<enemy2X.length;i++){  
                enemy2X[i]=enemy2X[0]-spacing*i;
                enemy2Y[i]=enemyDefaultY+spacing*i;
                if((enemy2X[i]-30<=fighterX) && (fighterX<=enemy2X[i]+30) && (enemy2Y[i]-30<=fighterY) && (fighterY<=enemy2Y[i]+30)){
                  blood -=(200/100)*20; 
                  println(enemy2X[i]);
                  disappear = enemy2X[i]+1000;
                  image(enemy,disappear,enemy2Y[i]);
                  for(int j=0;j<flame.length;j++){
                      image(flame[j],enemy2X[i],enemy2Y[i]+1000);
                      frameRate(100);
                      }
                     if(blood<=0){
                        gameState = GAME_LOSE;
                       }  
                  }
                  for(int j=0;j<Num;j++){
                    if((enemy1X[i]-30<=bulletX[j]) && (bulletX[i]<=enemy1X[i]+30) && (enemy1Y[i]-30<=bulletY[i]) && (bulletY[i]<=enemy1Y[i]+30)){
                      disappear = enemy1X[i]+1000; 
                      image(enemy,disappear,enemy1Y[i]+1000);
                      for(int k=0;k<flame.length;k++){
                        image(flame[k],enemy1X[i],enemy1Y[i]);
                        frameRate(100);
                        }
                        bulletNum[j] = false;
                    }
                  }
                image(enemy,enemy2X[i],enemy2Y[i]);
             }
           }
           break;
         case "a": 
           if(enemy3X[0]-4*spacing>=640){
              enemy3X[0]=0;
              enemyDefaultY = floor(random(50,420));
              ENEMY_STYLE = "c";
            }else{
              enemy3X[0]+=speedEnemyX;
              for(int i=0;i<8;i++){
                if(i-4==3||i-4==-3){
                    enemy3X[i] = enemy3X[0]-spacing*1;
                    enemy3Y[i] = enemyDefaultY-spacing*1/3*(i-4);                  
                   }else if(i-4==2||i-4==-2){
                      enemy3X[i] = enemy3X[0]-spacing*2;
                      enemy3Y[i] = enemyDefaultY-spacing*(i-4);
                   }else if(i-4==1||i-4==-1){
                      enemy3X[i] = enemy3X[0]-spacing*3;
                      enemy3Y[i] = enemyDefaultY-spacing*(i-4);
                   }else{
                     enemy3X[i] = enemy3X[0]-spacing*i;
                     enemy3Y[i] = enemyDefaultY;
                   }
                 if((enemy3X[i]-30<=fighterX) && (fighterX<=enemy3X[i]+30) && (enemy3Y[i]-30<=fighterY) && (fighterY<=enemy3Y[i]+30)){
                      blood -=(200/100)*20;
                      println(enemy3X[i]);
                      disappear = enemy3X[i]+1000;
                      image(enemy,disappear,enemy3Y[i]+1000);
                      for(int j=0;j<flame.length;j++){
                        image(flame[j],enemy3X[i],enemy3Y[i]);
                        frameRate(100);
                        }
                       if(blood<=0){
                          gameState = GAME_LOSE;
                         }  
                    }
                   for(int j=0;j<Num;j++){
                      if((enemy1X[i]-30<=bulletX[j]) && (bulletX[i]<=enemy1X[i]+30) && (enemy1Y[i]-30<=bulletY[i]) && (bulletY[i]<=enemy1Y[i]+30)){
                        disappear = enemy1X[i]+1000; 
                        image(enemy,disappear,enemy1Y[i]+1000);
                        for(int k=0;k<flame.length;k++){
                          image(flame[k],enemy1X[i],enemy1Y[i]);
                          frameRate(100);
                          }
                          bulletNum[j] = false;
                      }
                    }
               image(enemy,enemy3X[i],enemy3Y[i]);
              }
           }
           break;
       } 
      //fighter
      if(upPressed){
        fighterY -= speedFighter;
        while(fighterY<0){
          fighterY = 0;
          break;
        }
      }
      if(downPressed){
        fighterY += speedFighter;
        while(fighterY>height-50){
          fighterY = height-50;
          break;
        }
      }
      if(leftPressed){
        fighterX -= speedFighter;
        while(fighterX<0){
          fighterX = 0;
          break;
        }
      }
      if(rightPressed){
        fighterX += speedFighter;
        while(fighterX>width-50){
          fighterX = width-50;
          break;
        }
      }
      image(fighter,fighterX,fighterY);
      break;
    case GAME_LOSE:
      image(end2,0,0,640,480);
      if(mouseX>=180 && mouseX<=450 && mouseY>=280 && mouseY<=360){
        image(end1,0,0,640,480);
        if(mousePressed){
          setup();
          gameState = GAME_START;
        }
       }
     break;
  }
}
void keyPressed(){
  if(key== CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
   if(key== CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}

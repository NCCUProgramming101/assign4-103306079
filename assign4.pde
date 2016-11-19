PImage start1,start2,treasure,fighter,enemy,end1,end2,bulley,bg1,bg2,bg3,bg4,hp,bullet;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState;
int x;
int blood;
int treasureX,treasureY;
int enemySpeed =5;
int fighterX,fighterY;
int fighterSpeed = 5;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
String enemyState;
PImage [] enemyPosition = new PImage [5];
float enemyC [][] = new float [5][2];       
float enemyB [][] = new float [5][2];
float enemyA [][] = new float [8][2];  
int spacingX;
int spacingY;
int flame;
int flameCurrent;
PImage [] hit = new PImage [5];
float hitPosition [][] = new float [5][2]; 
float enemyY;
float [] bulletX = new float [5];
float [] bulletY = new float [5];
int bulletSpeed=8;
int n = 0;
boolean [] bulletNum = new boolean[5];

void setup () {    
  size (640,480) ;
  frameRate(60);
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
  bullet = loadImage ("img/shoot.png");      
  for ( int i = 0; i < 5; i++ ){
    hit[i] = loadImage ("img/flame" + (i+1) + ".png" );
  }
    
  //treasure
  treasureX = floor(random(50, 590));
  treasureY = floor(random(50, 430));
  
  //enemy
  spacingX = 0;  
  spacingY = -60; 
  enemyY = floor(random(80, 400));    
  for (int i = 0; i < 5; i++){
   enemyPosition [i] = loadImage ("img/enemy.png");  
   enemyC [i][0] = spacingX;
   enemyC [i][1] = enemyY; 
   spacingX -= 80;
  }
  enemySpeed = 5;
  
  //fighter
  fighterX = width-50;
  fighterY = height/2 ; 
  fighterSpeed = 5;
  
  //blood
  blood  = (200/100)*20;
  
  //flame
  flame=0;
  flameCurrent = 0;
  for ( int i = 0; i < hitPosition.length; i ++){
    hitPosition[i][0] = 2000;
    hitPosition[i][1] = 2000;
  }

  //no bullet
  for (int i =0; i < bulletNum.length ; i ++){
    bulletNum[i] = false;
  }
  
  gameState = GAME_START;
  enemyState ="c";
}


void draw() {
  switch (gameState) {
    case GAME_START:
      image (start2, 0, 0);     
      if (mouseX>=150 && mouseX<=450 && mouseY>=350 && mouseY<=430){
            image(start1, 0, 0);
            if(mousePressed){
              gameState = GAME_RUN;
            }
      }
    break;    
    case GAME_RUN:
      //bg
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
      
      //treasure
      image (treasure, treasureX, treasureY);    
      
      //fighter
      image(fighter, fighterX, fighterY);
      
      if (upPressed && fighterY > 0) {
        fighterY -= fighterSpeed ;
      }
      if (downPressed && fighterY < 480 - 50) {
        fighterY += fighterSpeed ;
      }
      if (leftPressed && fighterX > 0) {
        fighterX -= fighterSpeed ;
      }
      if (rightPressed && fighterX < 640 - 50) {
        fighterX += fighterSpeed ;
      }  

      //shoot      

      //flame
      image(hit[flameCurrent], hitPosition[flameCurrent][0], hitPosition[flameCurrent][1]);      
      flame++;
      if ( flame%6 == 0){
        flameCurrent ++;
      } 
      if ( flameCurrent > 4){
        flameCurrent = 0;
      }
      //flame buring
      if(flame>31){
        for (int i = 0; i < 5; i ++){
          hitPosition[i][0] = 1000;
          hitPosition[i][1] = 1000;
        }
      }   
      
     //bullet
      for (int i = 0; i < 5; i ++){
        if (bulletNum[i] == true){
          image (bullet, bulletX[i], bulletY[i]);
          bulletX[i] -= bulletSpeed;
        }
        if (bulletX[i] < - bullet.width){
          bulletNum[i] = false;
        }
      }
    
      //enemy
      switch (enemyState) { 
        case "c" :               
          for ( int i = 0; i < 5; i++ ){
            image(enemyPosition[i], enemyC [i][0], enemyC [i][1]);
            for (int j = 0; j < 5; j++ ){
              if(bulletX[j] >= enemyC [i][0] - bullet.width && bulletX[j] <= enemyC[i][0] + enemy.width 
                && bulletY[j] >= enemyC [i][1] - bullet.height && bulletY[j] <= enemyC [i][1] + enemy.height && bulletNum[j] == true){
                for (int k = 0;  k < 5; k++ ){
                  hitPosition [k][0] = enemyC [i][0];
                  hitPosition [k][1] = enemyC [i][1];
                }    
                enemyC [i][1] = -1000;
                enemyY = floor(random(30,240));
                bulletNum[j] = false;
                flame=0; 
              }
            }  
            if(fighterX >= enemyC [i][0] - fighter.width && fighterX <= enemyC[i][0] + enemy.width 
              && fighterY >= enemyC [i][1] - fighter.height && fighterY <= enemyC [i][1] + enemy.height){
              for (int j = 0;  j < 5; j++){
                hitPosition [j][0] = enemyC [i][0];
                hitPosition [j][1] = enemyC [i][1];
              }
              blood -= (200/100)*20;          
              enemyC [i][1] = -1000;
              enemyY = floor( random(30,240) );
              flame=0; 
            }else if(blood <= 0){
              gameState = GAME_OVER;
            } else {
              enemyC [i][0] += enemySpeed;
              enemyC [i][0] %= 1280;
            }      
          }
          if (enemyC [enemyC.length-1][0] > 640+100 ) {        
            enemyY = floor(random(30,240));            
            spacingX = 0;  
            for (int i = 0; i < 5; i++){
              enemyB [i][0] = spacingX;
              enemyB[i][1] = enemyY - spacingX / 2;
              spacingX -= 80;                 
            }
            enemyState = "b";
          }
        break ;        
        case "b" :
          for (int i = 0; i < 5; i++ ){
            image(enemyPosition[i], enemyB [i][0] , enemyB [i][1]);
            for(int j = 0; j < 5; j++){
              if ( bulletX[j] >= enemyB [i][0] - bullet.width && bulletX[j] <= enemyB[i][0] + enemy.width 
                && bulletY[j] >= enemyB [i][1] - bullet.height && bulletY[j] <= enemyB [i][1] + enemy.height && bulletNum[j] == true){
                for(int k = 0;  k < 5; k++ ){
                  hitPosition [k][0] = enemyB [i][0];
                  hitPosition [k][1] = enemyB [i][1];
                }     
                enemyB [i][1] = -1000;
                enemyY = floor(random(30,240));
                bulletNum[j] = false;
                flame=0;
              }
            }   
            if (fighterX >= enemyB [i][0] - fighter.width && fighterX <= enemyB[i][0] + enemy.width 
              && fighterY >= enemyB [i][1] - fighter.height && fighterY <= enemyB [i][1] + enemy.height){
              for (int j = 0;  j < 5; j++ ){
                 hitPosition [j][0] = enemyB [i][0];
                 hitPosition [j][1] = enemyB [i][1];
               }
              enemyB [i][1] = -1000;
              enemyY = floor(random(200,280));
              flame=0; 
              blood-= (200/100)*20;
            }else if(blood<= 0){
              gameState = GAME_OVER;
            } else {
              enemyB [i][0] += enemySpeed;
              enemyB [i][0] %= 1280;
            }         
          }
          if (enemyB [4][0] > 640 + 100){
            enemyY = floor(random(200,280));
            enemyState = "a";            
            spacingX = 0;  
            spacingY = -60; 
            for ( int i = 0; i < 8; i ++ ) {
              if ( i < 3 ) {
                enemyA [i][0] = spacingX;
                enemyA [i][1] = enemyY - spacingX;
                spacingX -= 60;
              } else if ( i == 3 ){
                enemyA [i][0] = spacingX;
                enemyA [i][1] = enemyY - spacingY;
                spacingX -= 60;
                spacingY += 60;
              } else if ( i > 3 && i <= 5 ){
                  enemyA [i][0] = spacingX;
                  enemyA [i][1] = enemyY + spacingY;
                  spacingX += 60;
                  spacingY -= 60;
              } else {
                  enemyA [i][0] = spacingX;
                  enemyA [i][1] = enemyY + spacingY;
                  spacingX += 60;
                  spacingY += 60;
              }            
            }     
          }
        break ;                
        case "a" :  
          for( int i = 0; i < 8; i++ ){
            image(enemy, enemyA [i][0], enemyA [i][1]);        
            for( int j = 0; j < 5; j++ ){
              if ( bulletX[j] >= enemyA [i][0] - bullet.width && bulletX[j] <= enemyA [i][0] + enemy.width 
                && bulletY[j] >= enemyA [i][1] - bullet.height && bulletY[j] <= enemyA [i][1] + enemy.height && bulletNum[j] == true){
            
                  for (int k = 0;  k < 5; k++){
                  hitPosition [k][0] = enemyA [i][0];
                  hitPosition [k][1] = enemyA [i][1];
                }
                enemyA [i][1] = -1000;
                enemyY = floor( random(30,240));
                bulletNum[j] = false;
                flame=0; 
              }
            }       
            if ( fighterX >= enemyA [i][0] - fighter.width && fighterX <= enemyA[i][0] + enemy.width 
                && fighterY >= enemyA [i][1] - fighter.height  && fighterY <= enemyA [i][1] + enemy.height){ 
                for ( int j = 0;  j < 5; j++ ){
                  hitPosition [j][0] = enemyA [i][0];
                  hitPosition [j][1] = enemyA [i][1];
                }
                blood -= (200/100)*20;
                enemyA [i][1] = -1000;
                enemyY = floor(random(50,420));
                flame=0; 
              } else if ( blood <= 0 ) {
                gameState = GAME_OVER;
              } else {
                enemyA [i][0] += enemySpeed;
                enemyA [i][0] %= 1920;
              }     
          }
          if(enemyA [4][0] > 640 + 300 ){
            enemyY = floor(random(80,400));
            spacingX = 0;       
            for (int i = 0; i < 5; i++ ){
              enemyC [i][1] = enemyY; 
              enemyC [i][0] = spacingX;
              spacingX -= 80;
            } 
            enemyState = "c";            
          }            
        break ;
      }
      //treasure
      if(fighterX >= treasureX - fighter.width && fighterX <= treasureX + treasure.width
         && fighterY >= treasureY - fighter.height && fighterY <= treasureY + treasure.height){    
              blood += (200/100)*10;
              treasureX = floor(random(50,600));         
              treasureY = floor(random(50,420));
      }
      if(blood >= 200){
        blood= 200;
        }
    break ; 
    case GAME_OVER :
      image(end2, 0, 0);     
      if ( mouseX>=180 && mouseX<=450 && mouseY>=280 && mouseY<=360){
            image(end1, 0, 0);
            if(mousePressed){
              setup();
              gameState = GAME_START;
            }
      }
    break;
  }  
}
void keyPressed (){
  if (key == CODED) {
    switch ( keyCode ) {
      case UP :
        upPressed = true ;
        break ;
      case DOWN :
        downPressed = true ;
        break ;
      case LEFT :
        leftPressed = true ;
        break ;
      case RIGHT :
        rightPressed = true ;
        break ;
    }
  }
}

void keyReleased () {
  if (key == CODED) {
    switch ( keyCode ) {
      case UP : 
        upPressed = false ;
        break ;
      case DOWN :
        downPressed = false ;
        break ;
      case LEFT :
        leftPressed = false ;
        break ;
      case RIGHT :
        rightPressed = false ;
        break ;
      }  
    }  
   if ( keyCode == ' '){
          if (gameState == GAME_RUN){
            if (bulletNum[n] == false){
              bulletNum[n] = true;
              bulletX[n] = fighterX-30;
              bulletY[n] = fighterY+15;
              n ++;
            }   
            if (n> 4) {
              n=0;
            }
          }
        }
      }

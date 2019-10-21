PImage startScreen;
int gameState=0;
float sideWalkX;
float sWXTotal=0;
int fenceX;
int fenceY;
int planted=0;
button sfButton;
button psButton;
button spButton;
button rButton;
sun S;
int buttonSFClicked=0;
int buttonPSClicked=0;
int buttonSPClicked=0;
int buttonRClicked=0;
int frameZombie=0;
int numZombies=0;
int zombiesRemoved=0;
int deadFrame=0;

zombie Z;
plant PS;
plant SP;
plant R;
sunFlower SF;
boolean sunClicked=false;
boolean snowPeaHit=false;
ArrayList<zombie> deadZombie=new ArrayList<zombie>();
ArrayList<zombie> zombies=new ArrayList<zombie>();
ArrayList<sun> suns = new ArrayList<sun>();
ArrayList<sunFlower> activeSF = new ArrayList<sunFlower>();
ArrayList<sunFlower> placedSF = new ArrayList<sunFlower>();
ArrayList<plant> activePS = new ArrayList<plant>();
ArrayList<plant> placedPS = new ArrayList<plant>();
ArrayList<plant> activeSP = new ArrayList<plant>();
ArrayList<plant> placedSP = new ArrayList<plant>();
ArrayList<plant> activeR = new ArrayList<plant>();
ArrayList<plant> placedR = new ArrayList<plant>();
ArrayList<pea> peas=new ArrayList<pea>();
ArrayList<pea> snowPea=new ArrayList<pea>();
ArrayList<pea> doublePea=new ArrayList<pea>();
ArrayList<sun> fallingSuns= new ArrayList<sun>();
void setup() {
  size(900, 700);
  startScreen=loadImage("startScreen.jpg");
  sfButton=new button(100, 10);
  psButton=new button(200, 10);
  spButton=new button(300, 10);
  rButton=new button(400, 10);
  S=new sun(50, 40, 1);
  Z=new zombie(500, 530, 1, 0, 1);
  PS=new plant(450, 250, 1);
  SP=new plant(450, 250, 1);
  R=new plant(450, 250, 1);
  SF=new sunFlower(500, 600, 1);
}

void mousePressed() {
  for (int i=0; i<fallingSuns.size (); i++) {
    if (fallingSuns.get(i).posX<=mouseX+24 && fallingSuns.get(i).posX>=mouseX-24 && fallingSuns.get(i).posY<=mouseY+24 && fallingSuns.get(i).posY>=mouseY-24) {
      fallingSuns.remove(i);
      S.sunCount+=25;
      sunClicked=true;
    }
  }
  for (int i=0; i<suns.size (); i++) {
    if (suns.get(i).posX<=mouseX+24 && suns.get(i).posX>=mouseX-24 && suns.get(i).posY<=mouseY+24 && suns.get(i).posY>=mouseY-24) {
      suns.remove(i);
      S.sunCount+=25;
    }
  }
  if (sunClicked==false) {
    if (buttonSFClicked==1) {
      buttonSFClicked=2;
    } else if (buttonPSClicked==1) {
      buttonPSClicked=2;
    } else if (buttonSPClicked==1) {
      buttonSPClicked=2;
    } else if (buttonRClicked==1) {
      buttonRClicked=2;
    }
  }


  if (mouseX>=250 && mouseX<=550 && mouseY>=600 && mouseY<=650 && gameState==0) {
    gameState=1;
  }
  if (mouseX>=250 && mouseX<=650 && mouseY>=450 && mouseY<=525 && gameState==3) {
    gameState=4;
  }
  if (mouseX>=250 && mouseX<=650 && mouseY>=450 && mouseY<=525 && gameState==5) {
    gameState=6;
  }
  if (mouseX>=250 && mouseX<=650 && mouseY>=450 && mouseY<=525 && gameState==7) {
    gameState=0;
  }
  if (mouseX>=250 && mouseX<=650 && mouseY>=550 && mouseY<=625 && gameState==2) {
    gameState=0;
  }
  if (mouseX>=100 && mouseX<=170 && mouseY>=10 && mouseY<=90 && S.sunCount>=50) {
    activeSF.add(new sunFlower(mouseX, mouseY, 0.35));
    buttonSFClicked=1;
    S.sunCount-=50;
  }
  if (mouseX>=200 && mouseX<=270 && mouseY>=10 && mouseY<=90 && S.sunCount>=100) {
    activePS.add(new plant(mouseX, mouseY, 0.5));
    buttonPSClicked=1;
    S.sunCount-=100;
  }
  if (mouseX>=300 && mouseX<=370 && mouseY>=10 && mouseY<=90 && S.sunCount>=175) {
    activeSP.add(new plant(mouseX, mouseY, 0.5));
    buttonSPClicked=1;
    S.sunCount-=175;
  }
  if (mouseX>=400 && mouseX<=470 && mouseY>=10 && mouseY<=90 && S.sunCount>=200) {
    activeR.add(new plant(mouseX, mouseY, 0.5));
    buttonRClicked=1;
    S.sunCount-=200;
  }
  sunClicked=false;
}
boolean plantCollision(plant p, zombie z) {
  if (p.cx>=z.posX-80 && p.cx<=z.posX-30 && p.cy<=z.posY && p.cy>=z.posY-100) {
    return true;
  }
  return false;
}
boolean inLane(plant p, zombie z) {
  if (p.cy<=z.posY && p.cy>=z.posY-100) {
    return true;
  }
  return false;
}
void drawFence(int x, int y) {
  fenceX=x;
  fenceY=y;
  pushMatrix();
  translate(fenceX, fenceY);
  translate(-0, -30);
  beginShape();
  vertex(0, 100);
  vertex(0, 20);
  vertex(20, -20);
  vertex(40, 20);
  vertex(40, 100);  
  endShape();
  popMatrix();
}

boolean collision(pea P, zombie Z) {
  if (P.posX+10>=Z.posX-50 &&  P.posX+10<=Z.posX-30 && P.posY<=Z.posY && P.posY>=Z.posY-100) {
    return true;
  }
  return false;
}
boolean sunflowerCollision(sunFlower s, zombie z) {
  if (s.posX>=z.posX-80 && s.posX<=z.posX-30 && s.posY<=z.posY && s.posY>=z.posY-100) {
    return true;
  }
  return false;
}
void drawBackground() {
  background(119, 186, 240);
  fill(191, 150, 100);
  rect(0, 100, 900, 600);
  fill(214, 232, 208);
  rect(0, 30, 850, 30);
  rect(0, 75, 850, 30);
  for (int i=0; i<11; i++) {
    fill(214, 232, 208);
    drawFence(0+(i*81), 30);
  }
  for (int j=0; j<5; j++) {
    for (int i=0; i<9; i++) {
      if (j%2==0) {
        if (i%2==0) {
          fill(80, 206, 40);
          rect(50+(91.5*i), 100+(114*j), 91.5, 114);
        } else {
          fill(67, 165, 35);
          rect(50+(91.5*i), 100+(114*j), 91.5, 114);
        }
      } else {
        if (i%2==0) {
          fill(60, 227, 53);
          rect(50+(91.5*i), 100+(114*j), 91.5, 114);
        } else {
          fill(80, 206, 40);
          rect(50+(91.5*i), 100+(114*j), 91.5, 114);
        }
      }
    }
  }
  for (int i=0; i<9; i++) {  
    fill(214, 232, 208);
    rect(0+(i*110), 670, 110, 30);
    if (i<6) {
      rect(870, 100+(i*95), 30, 95);
      rect(0, 100+(i*95), 50, 95);
    }
  }
  fill(157, 110, 65);
  rect(0, 0, 630, 100);
  fill(116, 62, 12);
  rect(10, 10, 80, 80);
  rect(100, 10, 520, 80);
  fill(157, 110, 65);
  ellipse(50, 40, 60, 60);
  fill(116, 62, 12);
  ellipse(50, 40, 50, 50);   
  S.drawSun();
  S.drawSC();
  sfButton.drawSFButton(); 
  psButton.drawPSButton();
  spButton.drawSPButton();
  rButton.drawRButton();
}
void draw() {
  if (gameState==0) {
    startScreen.resize(900, 700);
    image(startScreen, 0, 0);
    fill(70, 46, 11);
    rect(250, 600, 300, 50);
    String s = "Click to start";
    fill(255, 255, 255);
    textSize(32);
    textAlign(CENTER);
    text(s, 250, 600, 300, 50);
  } else if (gameState==1) {
    if (zombiesRemoved<15) {
      drawBackground();
      if (numZombies<15 && frameZombie%500==0 && frameZombie>499) {
        zombies.add(new zombie(1000, ((int)random(2, 7))*114, 0.4, 1, 1));
        numZombies+=1;
      }
      if (frameZombie==1) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      if (frameZombie%100==0 && frameZombie>99) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      for (int i=0; i<fallingSuns.size (); i++) {

        fallingSuns.get(i).drawSun();
        fallingSuns.get(i).framecount+=1;
        if (fallingSuns.get(i).framecount<=640) {
          fallingSuns.get(i).update();
        }
        if (frameCount%2500==0) {
          fallingSuns.remove(i);
        }
      }

      if (peas.size()==0 && snowPea.size()==0 && doublePea.size()==0 && zombies.size()>0) {
        for (int i=0; i<zombies.size (); i++) {
          if (zombies.get(i).type==1) {
            zombies.get(i).drawZombie();
            zombies.get(i).animateLegs();
          } 
          zombies.get(i).update();
          if (zombies.get(i).posX<=50) {
            gameState=2;
            zombies.remove(i);
            for (int j=0; j<suns.size (); j++) {
              suns.remove(j);
            }
            for (int j=0; j<placedSF.size (); j++) {
              placedSF.remove(j);
            }
            for (int j=0; j<placedPS.size (); j++) {
              placedPS.remove(j);
            }
            for (int j=0; j<placedSP.size (); j++) {
              placedSP.remove(j);
            }
            for (int j=0; j<placedR.size (); j++) {
              placedR.remove(j);
            }
            for (int j=0; j<fallingSuns.size (); j++) {
              fallingSuns.remove(j);
            }
            for (int j=0; j<peas.size (); j++) {
              peas.remove(j);
            }
            for (int j=0; j<snowPea.size (); j++) {
              snowPea.remove(j);
            }
            for (int j=0; j<doublePea.size (); j++) {
              doublePea.remove(j);
            }
          }
        }
      } else if ((peas.size()>0 || snowPea.size()>0 || doublePea.size()>0) && zombies.size()>0) {  

        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedPS.size (); i++) {
            if (plantCollision(placedPS.get(i), zombies.get(j))==true) {
              placedPS.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedSP.size (); i++) {
            if (plantCollision(placedSP.get(i), zombies.get(j))==true) {
              placedSP.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedR.size (); i++) {
            if (plantCollision(placedR.get(i), zombies.get(j))==true) {
              placedR.remove(i);
            }
          }
        }

        for (int i=0; i<peas.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(peas.get(i), zombies.get(j))==true) {
              peas.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                deadZombie.add(new zombie(zombies.get(j).posX, zombies.get(j).posY, 0.4, 1, 1));
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<doublePea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(doublePea.get(i), zombies.get(j))==true) {
              doublePea.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                deadZombie.add(new zombie(zombies.get(j).posX, zombies.get(j).posY, 0.4, 1, 1));
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<snowPea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(snowPea.get(i), zombies.get(j))==true) {
              snowPea.remove(i);
              zombies.get(j).speed-=zombies.get(j).speed/2;
              snowPeaHit=true;
            }
          }
        }
        for (int j=0; j<deadZombie.size (); j++) {
          deadZombie.get(j).drawDeadZombie();
          if (deadZombie.get(j).dy==151) {
            deadZombie.remove(j);
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          if (zombies.get(j).type==1) {
            zombies.get(j).drawZombie();
            zombies.get(j).animateLegs();
          }
          zombies.get(j).update();
          if (zombies.get(j).posX<=50) {
            gameState=2;
            zombies.remove(j);
            for (int i=0; i<suns.size (); i++) {
              suns.remove(i);
            }
            for (int i=0; i<placedSF.size (); i++) {
              placedSF.remove(i);
            }
            for (int i=0; i<placedPS.size (); i++) {
              placedPS.remove(i);
            }
            for (int i=0; i<placedSP.size (); i++) {
              placedSP.remove(i);
            }
            for (int i=0; i<placedR.size (); i++) {
              placedR.remove(i);
            }
            for (int i=0; i<fallingSuns.size (); i++) {
              fallingSuns.remove(i);
            }
            for (int i=0; i<peas.size (); i++) {
              peas.remove(i);
            }
            for (int i=0; i<snowPea.size (); i++) {
              snowPea.remove(i);
            }
            for (int i=0; i<doublePea.size (); i++) {
              doublePea.remove(i);
            }
          }
        }
      }

      for (int j=0; j<zombies.size (); j++) {
        for (int i=0; i<placedSF.size (); i++) {
          if (sunflowerCollision(placedSF.get(i), zombies.get(j))==true) {
            placedSF.remove(i);
          }
        }
      }
      for (int i=0; i<activeSF.size (); i++) {
        activeSF.get(i).drawSF();
        if (buttonSFClicked==1) {
          activeSF.get(i).update();
        } else if (buttonSFClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedSF.add(new sunFlower(92+(float)(k*91.5), 190+(float)(t*114), 0.35));
                activeSF.remove(i);
                buttonSFClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedSF.size (); i++) {
        placedSF.get(i).drawSF();
        placedSF.get(i).framecount+=1;
        if (placedSF.get(i).framecount%400==0) {
          suns.add(new sun(placedSF.get(i).posX, placedSF.get(i).posY, 1));
        }
      }
      for (int i=0; i<suns.size (); i++) {
        suns.get(i).drawSun();
        suns.get(i).framecount+=1;
        if (suns.get(i).framecount<= 25) {
          suns.get(i).update();
        }
        if (suns.get(i).framecount%300==0) {
          suns.remove(i);
        }
      }
      for (int i=0; i<activePS.size (); i++) {
        activePS.get(i).drawPeaShooter();
        if (buttonPSClicked==1) {
          activePS.get(i).update();
        } else if (buttonPSClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedPS.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activePS.remove(i);
                buttonPSClicked=0;
              }
            }
          }
        }
      }

      for (int i=0; i<placedPS.size (); i++) {
        placedPS.get(i).drawPeaShooter();
        placedPS.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedPS.get(i), zombies.get(j))==true && placedPS.get(i).framecount%100==0) {
            peas.add(new pea(placedPS.get(i).cx, placedPS.get(i).cy));
          }
        }
      }
      for (int i=0; i<peas.size (); i++) {
        peas.get(i).drawPea();
        peas.get(i).update();
        if (peas.get(i).posX>900) {
          peas.remove(i);
        }
      }
      for (int i=0; i<activeSP.size (); i++) {
        activeSP.get(i).drawSnowPea();
        if (buttonSPClicked==1) {
          activeSP.get(i).update();
        } else if (buttonSPClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedSP.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeSP.remove(i);
                buttonSPClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedSP.size (); i++) {
        placedSP.get(i).drawSnowPea();
        placedSP.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedSP.get(i), zombies.get(j))==true && placedSP.get(i).framecount%100==0) {
            snowPea.add(new pea(placedSP.get(i).cx, placedSP.get(i).cy));
          }
        }
      }
      for (int i=0; i<snowPea.size (); i++) {
        snowPea.get(i).drawSnow();
        snowPea.get(i).update();
        if (snowPea.get(i).posX>900) {
          snowPea.remove(i);
        }
      }
      for (int i=0; i<activeR.size (); i++) {
        activeR.get(i).drawRepeater();
        if (buttonRClicked==1) {
          activeR.get(i).update();
        } else if (buttonRClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedR.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeR.remove(i);
                buttonRClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedR.size (); i++) {
        placedR.get(i).drawRepeater();
        placedR.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedR.get(i), zombies.get(j))==true && placedR.get(i).framecount%100==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
          if (inLane(placedR.get(i), zombies.get(j))==true && (placedR.get(i).framecount%100)-20==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
        }
      }
      for (int i=0; i<doublePea.size (); i++) {
        doublePea.get(i).drawPea();
        doublePea.get(i).update();
        if (doublePea.get(i).posX>900) {
          doublePea.remove(i);
        }
      }
      frameZombie+=1;
    } else {
      gameState=3;
      numZombies=0;
      zombiesRemoved=0;
      frameZombie=0;
    }
  } else if (gameState==2) {
    for(int j=0; j<zombies.size();j++){
      zombies.remove(j);
    }
    for(int j=0; j<deadZombie.size(); j++){
      deadZombie.remove(j);
    }
    for (int j=0; j<suns.size (); j++) {
      suns.remove(j);
    }
    for (int j=0; j<placedSF.size (); j++) {
      placedSF.remove(j);
    }
    for (int j=0; j<placedPS.size (); j++) {
      placedPS.remove(j);
    }
    for (int j=0; j<placedSP.size (); j++) {
      placedSP.remove(j);
    }
    for (int j=0; j<placedR.size (); j++) {
      placedR.remove(j);
    }
    for (int j=0; j<fallingSuns.size (); j++) {
      fallingSuns.remove(j);
    }
    for (int j=0; j<peas.size (); j++) {
      peas.remove(j);
    }
    for (int j=0; j<snowPea.size (); j++) {
      snowPea.remove(j);
    }
    for (int j=0; j<doublePea.size (); j++) {
      doublePea.remove(j);
    }
    S.sunCount=0;
    frameZombie=0;
    background(255, 255, 255);
    fill(93, 49, 16);
    rect(250, 550, 400, 75);
    fill(0, 0, 0);
    textSize(32);
    text("The zombies have reached your house.", 450, 100);
    text("Click to play again", 450, 600);
    textAlign(CENTER);
    Z.drawZombie();
  } else if (gameState==3) {
    for (int j=0; j<suns.size (); j++) {
      suns.remove(j);
    }
    for (int j=0; j<placedSF.size (); j++) {
      placedSF.remove(j);
    }
    for (int j=0; j<placedPS.size (); j++) {
      placedPS.remove(j);
    }
    for (int j=0; j<placedSP.size (); j++) {
      placedSP.remove(j);
    }
    for (int j=0; j<placedR.size (); j++) {
      placedR.remove(j);
    }
    for (int j=0; j<fallingSuns.size (); j++) {
      fallingSuns.remove(j);
    }
    for (int j=0; j<peas.size (); j++) {
      peas.remove(j);
    }
    for (int j=0; j<snowPea.size (); j++) {
      snowPea.remove(j);
    }
    for (int j=0; j<doublePea.size (); j++) {
      doublePea.remove(j);
    }
    background(255, 255, 255);
    fill(93, 49, 16);
    rect(250, 450, 400, 75);
    fill(0, 0, 0);
    textSize(32);
    text("Wave 1 Cleared", 450, 150);
    text("Click to continue", 450, 500);
    textAlign(CENTER);
    PS.drawPeaShooter();
  } else if (gameState==4) {
    if (zombiesRemoved<15) {
      drawBackground();
      if (numZombies<15 && frameZombie%1000==0) {
        zombies.add(new zombie(1000, ((int)random(2, 7))*114, 0.4, 1, (int)random(1, 2)));
        numZombies+=1;
      }
      if (frameCount==1) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      if (frameCount%1000==0) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      for (int i=0; i<fallingSuns.size (); i++) {

        fallingSuns.get(i).drawSun();
        fallingSuns.get(i).framecount+=1;
        if (fallingSuns.get(i).framecount<=640) {
          fallingSuns.get(i).update();
        }
        if (frameCount%2500==0) {
          fallingSuns.remove(i);
        }
      }

      if (peas.size()==0 && snowPea.size()==0 && doublePea.size()==0 && zombies.size()>0) {
        for (int i=0; i<zombies.size (); i++) {
          if (zombies.get(i).type==1) {
            zombies.get(i).drawZombie();
          } else if (zombies.get(i).type==2) {
            zombies.get(i).drawConeZombie();
          }
          zombies.get(i).update();
          if (zombies.get(i).posX<=50) {
            gameState=2;
            zombies.remove(i);
            for (int j=0; j<suns.size (); j++) {
              suns.remove(j);
            }
            for (int j=0; j<placedSF.size (); j++) {
              placedSF.remove(j);
            }
            for (int j=0; j<placedPS.size (); j++) {
              placedPS.remove(j);
            }
            for (int j=0; j<placedSP.size (); j++) {
              placedSP.remove(j);
            }
            for (int j=0; j<placedR.size (); j++) {
              placedR.remove(j);
            }
            for (int j=0; j<fallingSuns.size (); j++) {
              fallingSuns.remove(j);
            }
            for (int j=0; j<peas.size (); j++) {
              peas.remove(j);
            }
            for (int j=0; j<snowPea.size (); j++) {
              snowPea.remove(j);
            }
            for (int j=0; j<doublePea.size (); j++) {
              doublePea.remove(j);
            }
          }
        }
      } else if ((peas.size()>0 || snowPea.size()>0 || doublePea.size()>0) && zombies.size()>0) {  

        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedPS.size (); i++) {
            if (plantCollision(placedPS.get(i), zombies.get(j))==true) {
              placedPS.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedSP.size (); i++) {
            if (plantCollision(placedSP.get(i), zombies.get(j))==true) {
              placedSP.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedR.size (); i++) {
            if (plantCollision(placedR.get(i), zombies.get(j))==true) {
              placedR.remove(i);
            }
          }
        }
        for (int i=0; i<peas.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(peas.get(i), zombies.get(j))==true) {
              peas.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<doublePea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {       
            if (collision(doublePea.get(i), zombies.get(j))==true) {
              doublePea.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<snowPea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(snowPea.get(i), zombies.get(j))==true) {
              snowPea.remove(i);
              zombies.get(j).speed-=zombies.get(j).speed/2;
              snowPeaHit=true;
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {

          if (zombies.get(j).type==1) {
            zombies.get(j).drawZombie();
          } else if (zombies.get(j).type==2) {
            zombies.get(j).drawConeZombie();
          }
          zombies.get(j).update();
          if (zombies.get(j).posX<=50) {
            gameState=2;
            zombies.remove(j);
            for (int i=0; i<suns.size (); i++) {
              suns.remove(i);
            }
            for (int i=0; i<placedSF.size (); i++) {
              placedSF.remove(i);
            }
            for (int i=0; i<placedPS.size (); i++) {
              placedPS.remove(i);
            }
            for (int i=0; i<placedSP.size (); i++) {
              placedSP.remove(i);
            }
            for (int i=0; i<placedR.size (); i++) {
              placedR.remove(i);
            }
            for (int i=0; i<fallingSuns.size (); i++) {
              fallingSuns.remove(i);
            }
            for (int i=0; i<peas.size (); i++) {
              peas.remove(i);
            }
            for (int i=0; i<snowPea.size (); i++) {
              snowPea.remove(i);
            }
            for (int i=0; i<doublePea.size (); i++) {
              doublePea.remove(i);
            }
          }
        }
      }
      for (int j=0; j<zombies.size (); j++) {
        for (int i=0; i<placedSF.size (); i++) {
          if (sunflowerCollision(placedSF.get(i), zombies.get(j))==true) {
            placedSF.remove(i);
          }
        }
      }
      for (int i=0; i<activePS.size (); i++) {
        activePS.get(i).drawPeaShooter();
        if (buttonPSClicked==1) {
          activePS.get(i).update();
        } else if (buttonPSClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedPS.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activePS.remove(i);
                buttonPSClicked=0;
              }
            }
          }
        }
      }

      for (int i=0; i<placedPS.size (); i++) {
        placedPS.get(i).drawPeaShooter();
        placedPS.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedPS.get(i), zombies.get(j))==true && placedPS.get(i).framecount%100==0) {
            peas.add(new pea(placedPS.get(i).cx, placedPS.get(i).cy));
          }
        }
      }
      for (int i=0; i<peas.size (); i++) {
        peas.get(i).drawPea();
        peas.get(i).update();
        if (peas.get(i).posX>900) {
          peas.remove(i);
        }
      }
      for (int i=0; i<activeSP.size (); i++) {
        activeSP.get(i).drawSnowPea();
        if (buttonSPClicked==1) {
          activeSP.get(i).update();
        } else if (buttonSPClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedSP.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeSP.remove(i);
                buttonSPClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedSP.size (); i++) {
        placedSP.get(i).drawSnowPea();
        placedSP.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedSP.get(i), zombies.get(j))==true && placedSP.get(i).framecount%100==0) {
            snowPea.add(new pea(placedSP.get(i).cx, placedSP.get(i).cy));
          }
        }
      }
      for (int i=0; i<snowPea.size (); i++) {
        snowPea.get(i).drawSnow();
        snowPea.get(i).update();
        if (snowPea.get(i).posX>900) {
          snowPea.remove(i);
        }
      }
      for (int i=0; i<activeR.size (); i++) {
        activeR.get(i).drawRepeater();
        if (buttonRClicked==1) {
          activeR.get(i).update();
        } else if (buttonRClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedR.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeR.remove(i);
                buttonRClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedR.size (); i++) {
        placedR.get(i).drawRepeater();
        placedR.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedR.get(i), zombies.get(j))==true && placedR.get(i).framecount%100==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
          if (inLane(placedR.get(i), zombies.get(j))==true && (placedR.get(i).framecount%100)-20==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
        }
      }
      for (int i=0; i<doublePea.size (); i++) {
        doublePea.get(i).drawPea();
        doublePea.get(i).update();
        if (doublePea.get(i).posX>900) {
          doublePea.remove(i);
        }
      }
      frameZombie+=1;
    } else {
      gameState=5;
      numZombies=0;
      zombiesRemoved=0;
      frameZombie=0;
    }
  } else if (gameState==5) {
    background(255, 255, 255);
    fill(93, 49, 16);
    rect(250, 450, 400, 75);
    fill(0, 0, 0);
    textSize(32);
    text("Wave 2 Cleared", 450, 150);
    text("Click to continue", 450, 500);
    textAlign(CENTER);
    SP.drawSnowPea();
  } else if (gameState==6) {
    if (zombiesRemoved<15) {
      drawBackground();
      if (numZombies<15 && frameZombie%1000==0) {
        zombies.add(new zombie(1000, ((int)random(2, 7))*114, 0.4, 1, (int)random(1, 3)));
        numZombies+=1;
      }
      if (frameCount==1) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      if (frameCount%1000==0) {
        fallingSuns.add(new sun(random(100, 800), 0, 1));
      }
      for (int i=0; i<fallingSuns.size (); i++) {

        fallingSuns.get(i).drawSun();
        fallingSuns.get(i).framecount+=1;
        if (fallingSuns.get(i).framecount<=640) {
          fallingSuns.get(i).update();
        }
        if (frameCount%2500==0) {
          fallingSuns.remove(i);
        }
      }

      if (peas.size()==0 && snowPea.size()==0 && doublePea.size()==0 && zombies.size()>0) {
        for (int i=0; i<zombies.size (); i++) {
          if (zombies.get(i).type==1) {
            zombies.get(i).drawZombie();
          } else if (zombies.get(i).type==2) {
            zombies.get(i).drawConeZombie();
          } else if (zombies.get(i).type==3) {
            zombies.get(i).drawBucketZombie();
          }
          zombies.get(i).update();
          if (zombies.get(i).posX<=50) {
            gameState=2;
            zombies.remove(i);
            for (int j=0; j<suns.size (); j++) {
              suns.remove(j);
            }
            for (int j=0; j<placedSF.size (); j++) {
              placedSF.remove(j);
            }
            for (int j=0; j<placedPS.size (); j++) {
              placedPS.remove(j);
            }
            for (int j=0; j<placedSP.size (); j++) {
              placedSP.remove(j);
            }
            for (int j=0; j<placedR.size (); j++) {
              placedR.remove(j);
            }
            for (int j=0; j<fallingSuns.size (); j++) {
              fallingSuns.remove(j);
            }
            for (int j=0; j<peas.size (); j++) {
              peas.remove(j);
            }
            for (int j=0; j<snowPea.size (); j++) {
              snowPea.remove(j);
            }
            for (int j=0; j<doublePea.size (); j++) {
              doublePea.remove(j);
            }
          }
        }
      } else if ((peas.size()>0 || snowPea.size()>0 || doublePea.size()>0) && zombies.size()>0) {  

        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedPS.size (); i++) {
            if (plantCollision(placedPS.get(i), zombies.get(j))==true) {
              placedPS.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedSP.size (); i++) {
            if (plantCollision(placedSP.get(i), zombies.get(j))==true) {
              placedSP.remove(i);
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          for (int i=0; i<placedR.size (); i++) {
            if (plantCollision(placedR.get(i), zombies.get(j))==true) {
              placedR.remove(i);
            }
          }
        }
        for (int i=0; i<peas.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {
            if (collision(peas.get(i), zombies.get(j))==true) {
              peas.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<doublePea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) {        
            if (collision(doublePea.get(i), zombies.get(j))==true) {
              doublePea.remove(i);
              zombies.get(j).health-=100;
              if (zombies.get(j).health<=0 ) {
                zombies.remove(j);
                zombiesRemoved+=1;
              }
            }
          }
        }
        for (int i=0; i<snowPea.size (); i++) {
          for (int j=0; j<zombies.size (); j++) { 
            if (collision(snowPea.get(i), zombies.get(j))==true) {
              snowPea.remove(i);
              zombies.get(j).speed-=zombies.get(j).speed/2;
              snowPeaHit=true;
            }
          }
        }
        for (int j=0; j<zombies.size (); j++) {
          if (zombies.get(j).type==1) {
            zombies.get(j).drawZombie();
          } else if (zombies.get(j).type==2) {
            zombies.get(j).drawConeZombie();
          } else if (zombies.get(j).type==3) {
            zombies.get(j).drawBucketZombie();
          }
          zombies.get(j).update();
          if (zombies.get(j).posX<=50) {
            gameState=2;
            zombies.remove(j);
            for (int i=0; i<suns.size (); i++) {
              suns.remove(i);
            }
            for (int i=0; i<placedSF.size (); i++) {
              placedSF.remove(i);
            }
            for (int i=0; i<placedPS.size (); i++) {
              placedPS.remove(i);
            }
            for (int i=0; i<placedSP.size (); i++) {
              placedSP.remove(i);
            }
            for (int i=0; i<placedR.size (); i++) {
              placedR.remove(i);
            }
            for (int i=0; i<fallingSuns.size (); i++) {
              fallingSuns.remove(i);
            }
            for (int i=0; i<peas.size (); i++) {
              peas.remove(i);
            }
            for (int i=0; i<snowPea.size (); i++) {
              snowPea.remove(i);
            }
            for (int i=0; i<doublePea.size (); i++) {
              doublePea.remove(i);
            }
          }
        }
      }
      for (int j=0; j<zombies.size (); j++) {
        for (int i=0; i<placedSF.size (); i++) {
          if (sunflowerCollision(placedSF.get(i), zombies.get(j))==true) {
            placedSF.remove(i);
          }
        }
      }
      for (int i=0; i<activePS.size (); i++) {
        activePS.get(i).drawPeaShooter();
        if (buttonPSClicked==1) {
          activePS.get(i).update();
        } else if (buttonPSClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedPS.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activePS.remove(i);
                buttonPSClicked=0;
              }
            }
          }
        }
      }

      for (int i=0; i<placedPS.size (); i++) {
        placedPS.get(i).drawPeaShooter();
        placedPS.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedPS.get(i), zombies.get(j))==true && placedPS.get(i).framecount%100==0) {
            peas.add(new pea(placedPS.get(i).cx, placedPS.get(i).cy));
          }
        }
      }
      for (int i=0; i<peas.size (); i++) {
        peas.get(i).drawPea();
        peas.get(i).update();
        if (peas.get(i).posX>900) {
          peas.remove(i);
        }
      }
      for (int i=0; i<activeSP.size (); i++) {
        activeSP.get(i).drawSnowPea();
        if (buttonSPClicked==1) {
          activeSP.get(i).update();
        } else if (buttonSPClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedSP.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeSP.remove(i);
                buttonSPClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedSP.size (); i++) {
        placedSP.get(i).drawSnowPea();
        placedSP.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedSP.get(i), zombies.get(j))==true && placedSP.get(i).framecount%100==0) {
            snowPea.add(new pea(placedSP.get(i).cx, placedSP.get(i).cy));
          }
        }
      }
      for (int i=0; i<snowPea.size (); i++) {
        snowPea.get(i).drawSnow();
        snowPea.get(i).update();
        if (snowPea.get(i).posX>900) {
          snowPea.remove(i);
        }
      }
      for (int i=0; i<activeR.size (); i++) {
        activeR.get(i).drawRepeater();
        if (buttonRClicked==1) {
          activeR.get(i).update();
        } else if (buttonRClicked==2) {
          for (int t=0; t<5; t++) {
            for (int k=0; k<9; k++) {
              if (mouseX>50+(float)(k*91.5) && mouseX<141.5+(float)(k*91.5) && mouseY>100+(float)(t*114) && mouseY<214+(float)(t*114)) {
                placedR.add(new plant(95.75+(float)(k*91.5), 128.5+(float)(t*114), 0.5));
                activeR.remove(i);
                buttonRClicked=0;
              }
            }
          }
        }
      }
      for (int i=0; i<placedR.size (); i++) {
        placedR.get(i).drawRepeater();
        placedR.get(i).framecount+=1;
        for (int j=0; j<zombies.size (); j++) {
          if (inLane(placedR.get(i), zombies.get(j))==true && placedR.get(i).framecount%100==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
          if (inLane(placedR.get(i), zombies.get(j))==true && (placedR.get(i).framecount%100)-20==0) {
            doublePea.add(new pea(placedR.get(i).cx, placedR.get(i).cy));
          }
        }
      }
      for (int i=0; i<doublePea.size (); i++) {
        doublePea.get(i).drawPea();
        doublePea.get(i).update();
        if (doublePea.get(i).posX>900) {
          doublePea.remove(i);
        }
      }
      frameZombie+=1;
    } else {
      gameState=7;
      numZombies=0;
      zombiesRemoved=0;
      frameZombie=0;
    }
  } else if (gameState==7) {
    background(255, 255, 255);
    fill(93, 49, 16);
    rect(250, 450, 400, 75);
    fill(0, 0, 0);
    textSize(32);
    text("All Waves Cleared", 450, 150);
    text("Click to play again", 450, 500);
    textAlign(CENTER);
    R.drawRepeater();
  }
}

class zombie {
  float posX, posY;
  float scal;
  float health;
  float speed;
  int type;
  float dx;
  float dy;
  float leftleg;
  boolean LeftBoolean;


  zombie(float x, float y, float s, float sp, int t) {
    posX=x;
    posY=y;
    scal=s;
    speed=sp;
    type=t;
    dx=200;
    dy=0;
    leftleg = 0;
    if (type==1) {
      health=500;
    } else if (type==2) {
      health=1000;
    } else if (type==3) {
      health=1500;
    }
  }

  void animateLegs() {
    if (leftleg > .2) {
      LeftBoolean = true;
    }
    if (leftleg < -.02) {
      LeftBoolean = false;
    }

    if (LeftBoolean == false) {
      leftleg += .005;
    } else {
      leftleg -= .005;
    }
  }

  void drawDeadZombie() {
    pushMatrix();
    if (dy < 150) {
      dy += 0.5;
    } else {
      dy=151;
    }
    if (dx >100) {
      dx -= 0.5;
    } else {
      dx = 101;
    }
    translate(posX, posY);
    scale(scal);
    translate(-306, -456);
    //head
    pushMatrix();
    pushMatrix();
    translate(dx, dy);
    translate(-146, 112);
    beginShape();
    fill(#9CB285);
    vertex(146, 112);
    vertex(139, 98);
    curveVertex(139, 98);
    curveVertex(139, 98);
    curveVertex(150, 97);
    curveVertex(161, 92);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(161, 77);
    curveVertex(150, 72);
    curveVertex(139, 78);
    curveVertex(139, 78);
    vertex(139, 78);
    vertex(136, 69);
    curveVertex(136, 69);
    curveVertex(136, 69);
    curveVertex(165, 48);
    curveVertex(206, 51);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(252, 94);
    curveVertex(256, 127);
    curveVertex(224, 150);
    curveVertex(224, 150);
    vertex(231, 146);
    vertex(233, 156);
    curveVertex(233, 156);
    curveVertex(233, 156);
    curveVertex(222, 162);
    curveVertex(211, 166);
    curveVertex(206, 165);
    curveVertex(206, 165);
    vertex(213, 156);
    vertex(206, 165);
    vertex(202.5, 169.5);
    vertex(202.5, 169.5);
    vertex(183, 176);
    vertex(163, 176);
    curveVertex(163, 176);
    curveVertex(163, 176);
    curveVertex(159, 173);
    curveVertex(159, 171);
    curveVertex(159, 167);
    curveVertex(159, 167);
    curveVertex(166, 167);
    curveVertex(166, 167);
    curveVertex(159, 167);
    curveVertex(150, 165);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(156, 156);
    curveVertex(164, 150);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(167, 144);
    curveVertex(167, 130);
    curveVertex(165, 119);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape(CLOSE);
    beginShape();
    curveVertex(160, 59);
    curveVertex(160, 59);
    curveVertex(169, 64);
    curveVertex(178, 65);
    curveVertex(189, 60);
    curveVertex(189, 60);
    endShape();
    beginShape();
    noFill();
    curveVertex(156, 64);
    curveVertex(156, 64);
    curveVertex(166, 69);
    curveVertex(179, 70);
    curveVertex(194, 65);
    curveVertex(194, 65);
    endShape();
    beginShape();
    noFill();
    curveVertex(167, 56);
    curveVertex(167, 56);
    curveVertex(171, 59);
    curveVertex(176, 59);
    curveVertex(180, 57);
    curveVertex(180, 57);
    endShape();
    beginShape();
    noFill();
    vertex(204, 156);
    vertex(200, 162);
    vertex(192, 162);
    endShape();
    beginShape();
    noFill();
    vertex(215, 144);
    vertex(225, 137);
    vertex(226, 126);
    vertex(234, 119);
    endShape();
    //mouth
    fill(#5D0B1E);
    beginShape();
    vertex(146, 112);
    vertex(185, 112);
    curveVertex(185, 110);
    curveVertex(185, 110);
    curveVertex(201, 126);
    curveVertex(199, 148);
    curveVertex(195, 157);
    curveVertex(195, 157);
    vertex(195, 157);
    vertex(155, 157);
    curveVertex(155, 157);
    curveVertex(155, 157);
    curveVertex(160, 153);
    curveVertex(163, 127);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape();
    //outsideeye
    fill(#F0E8E6);
    ellipse(149, 84, 25, 25);
    fill(0);
    ellipse(148, 83, 4, 4);
    //innereye
    fill(#F0E8E6);
    ellipse(212, 82, 40, 40);
    fill(0);
    ellipse(215, 81, 4, 4);
    //hair
    beginShape();
    noFill();
    curveVertex(147, 59);
    curveVertex(147, 59);
    curveVertex(143, 53);
    curveVertex(139, 48);
    curveVertex(129, 46);
    curveVertex(129, 46);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(160, 41);
    curveVertex(165, 34);
    curveVertex(172, 30);
    curveVertex(172, 30);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(155, 43);
    curveVertex(156, 36);
    curveVertex(168, 36);
    curveVertex(168, 36);
    endShape();
    beginShape();
    curveVertex(190, 48);
    curveVertex(190, 48);
    curveVertex(191, 42);
    curveVertex(196, 36);
    curveVertex(207, 35);
    curveVertex(207, 35);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(233, 63);
    curveVertex(233, 55);
    curveVertex(232, 51);
    curveVertex(232, 51);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(237, 63);
    curveVertex(238, 59);
    curveVertex(241, 55);
    curveVertex(241, 55);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(238, 68);
    curveVertex(243, 67);
    curveVertex(249, 68);
    curveVertex(249, 68);
    endShape();
    beginShape();
    noFill();
    curveVertex(253, 107);
    curveVertex(253, 107);
    curveVertex(259, 106);
    curveVertex(265, 106);
    curveVertex(270, 110);
    curveVertex(270, 110);
    endShape();
    beginShape();
    noFill();
    curveVertex(254, 111);
    curveVertex(254, 111);
    curveVertex(259, 111);
    curveVertex(264, 111);
    curveVertex(268, 115);
    curveVertex(268, 115);
    endShape();
    beginShape();
    noFill();
    curveVertex(251, 96);
    curveVertex(251, 96);
    curveVertex(257, 95);
    curveVertex(264, 95);
    curveVertex(271, 100);
    curveVertex(271, 100);
    endShape();
    //noseholes
    fill(0);
    ellipse(170, 99, 5, 10);
    ellipse( 181, 99, 6, 12);
    //teeth
    fill(255);
    rect(161, 112, 12, 10);
    rect(177, 112, 8, 8);
    rect(163, 152, 8, 5);
    rect(182, 150, 8, 7);
    popMatrix();
    //leftarm
    beginShape();
    fill(#6F4314);
    vertex(183, 176);
    vertex(177, 182);
    vertex(177, 249);
    vertex(160, 272);
    vertex(151, 275);
    vertex(151, 300);
    vertex(200, 300);
    vertex(200, 275);
    endShape();
    line(151, 275, 200, 275);
    //lefthand
    fill(#9CB285);
    beginShape();
    curveVertex(157, 301);
    curveVertex(157, 301);
    curveVertex(155, 315);
    curveVertex(153, 327);
    curveVertex(157, 333);
    curveVertex(157, 333);
    curveVertex(163, 334);
    curveVertex(167, 333);
    curveVertex(167, 331);
    curveVertex(167, 331);
    vertex(167, 331);
    vertex(163, 323);
    vertex(164, 318);
    curveVertex(167, 331);
    curveVertex(167, 331);
    curveVertex(172, 333);
    curveVertex(175, 333);
    curveVertex(176, 330);
    curveVertex(176, 330);
    vertex(176, 330);
    vertex(172, 322);
    vertex(173, 319);
    curveVertex(176, 330);
    curveVertex(176, 330);
    curveVertex(182, 329);
    curveVertex(185, 328);
    curveVertex(185, 324);
    curveVertex(185, 324);
    vertex(185, 324);
    vertex(182, 318);
    vertex(183, 313);
    curveVertex(185, 324);
    curveVertex(185, 324);
    curveVertex(190, 327);
    curveVertex(192, 324);
    curveVertex(192, 321);
    curveVertex(192, 321);
    vertex(192, 321);
    vertex(190, 314);
    curveVertex(190, 314);
    curveVertex(190, 314);
    curveVertex(194, 312);
    curveVertex(195, 308);
    curveVertex(191, 301);
    curveVertex(191, 301);
    vertex(191, 301);
    vertex(158, 301);
    curveVertex(156, 309);
    curveVertex(156, 309);
    curveVertex(162, 315);
    curveVertex(166, 312);
    curveVertex(165, 304);
    curveVertex(165, 304);
    endShape();
    ellipse(161, 309, 4, 4);

    //suit
    fill(#6F4314);
    beginShape();
    vertex(193, 174);
    vertex(192, 217);
    vertex(200, 275);
    fill(#BC8B55);
    vertex(214, 311);
    vertex(204, 216);
    vertex(202, 169);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(182, 177);
    vertex(192, 174);
    vertex(192, 197);
    vertex(187, 201);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 170);
    vertex(232, 156);
    vertex(224, 162);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 173);
    vertex(222, 178);
    vertex(205, 229);
    vertex(205, 233);
    vertex(232, 278);
    vertex(246, 245);
    vertex(237, 224);
    vertex(243, 175);
    vertex(234, 181);
    vertex(228, 173);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(270, 279);
    vertex(259, 302);
    vertex(286, 303);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(258, 303);
    vertex(263, 306);
    vertex(256, 326);
    vertex(286, 304);
    vertex(258, 303);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(202, 169);
    vertex(208, 177);
    vertex(203, 184);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 172);
    vertex(234, 182);
    vertex(244, 174);
    vertex(248, 151);
    vertex(234, 155);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(207, 238);
    vertex(215, 309);
    vertex(224, 288);
    vertex(228, 290);
    vertex(232, 280);
    vertex(207, 238);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(244, 174);
    vertex(237, 224);
    vertex(247, 246);
    vertex(263, 210);
    vertex(248, 151);
    endShape();
    fill(#DED1C3);
    beginShape();
    vertex(205, 235);
    vertex(232, 280);
    endShape();
    //rightcoat
    fill(#6F4314);
    beginShape();
    curveVertex(248, 151);
    curveVertex(248, 151);
    curveVertex(293, 161);
    curveVertex(310, 200);
    curveVertex(314, 250);
    curveVertex(314, 250);
    vertex(314, 250);
    vertex(314, 270);
    vertex(288, 306);
    vertex(270, 278);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(270, 278);
    vertex(278, 262);
    vertex(288, 305);
    endShape();
    //rightarm
    fill(#6F4314);
    beginShape();
    vertex(269, 197);
    vertex(264, 210);
    vertex(247, 246);
    vertex(228, 291);
    vertex(257, 304);
    vertex(297, 223);
    endShape();
    beginShape();
    vertex(224, 289);
    vertex(263, 307);
    vertex(254, 330);
    vertex(214, 311);
    vertex(224, 289);
    endShape();
    //righthand
    fill(#9CB285);
    beginShape();
    vertex(219, 314);
    vertex(219, 328);
    vertex(213, 339);
    vertex(210, 348);
    curveVertex(210, 348);
    curveVertex(210, 348);
    curveVertex(211, 356);
    curveVertex(216, 359);
    curveVertex(220, 351);
    curveVertex(220, 351);
    vertex(220, 351);
    vertex(220, 342);
    vertex(225, 335);
    vertex(227, 346);
    vertex(233, 355);
    curveVertex(233, 355);
    curveVertex(233, 355);
    curveVertex(237, 358);
    curveVertex(241, 359);
    curveVertex(242, 355);
    curveVertex(242, 355);
    vertex(242, 355);
    vertex(235, 345);
    vertex(235, 337);
    curveVertex(242, 355);
    curveVertex(242, 355);
    curveVertex(246, 357);
    curveVertex(247, 355);
    curveVertex(248, 352);
    curveVertex(248, 352);
    vertex(248, 352);
    vertex(244, 344);
    vertex(245, 339);
    vertex(250, 352);
    curveVertex(250, 352);
    curveVertex(250, 352);
    curveVertex(253, 353);
    curveVertex(256, 352);
    curveVertex(257, 349);
    curveVertex(257, 349);
    vertex(257, 349);
    vertex(250, 335);
    vertex(249, 329);
    endShape();
    ellipse(214, 352, 4, 4);
    ellipse(238, 355, 3, 3);
    //tie
    fill(#B91831);
    beginShape();
    vertex(202, 169);
    vertex(209, 178);
    vertex(221, 178);
    vertex(228, 172);
    vertex(223, 162);
    endShape();
    beginShape();
    vertex(209, 178);
    vertex(168, 226);
    vertex(176, 280);
    vertex(209, 228);
    vertex(221, 178);
    endShape();
    //tiestripes
    line(205, 183, 218, 190);
    line(195, 195, 214, 203);
    line(184, 207, 210, 220);
    line(168, 226, 202, 238);
    line(174, 258, 188, 260);
    //jeans
    //leftleg
    pushMatrix();
    translate(254, 330);
    rotate(leftleg);
    translate(-254, -330);
    fill(#2E3A83);
    beginShape();
    vertex(254, 330);
    vertex(276, 388);
    vertex(254, 436);
    vertex(297, 437);
    vertex(309, 390);
    vertex(288, 305);
    vertex(254, 330);
    endShape();
    //leftshoe
    fill(#6F4314);
    beginShape();
    vertex(254, 436);
    vertex(250, 452);
    vertex(320, 454);
    curveVertex(320, 454);
    curveVertex(320, 454);
    curveVertex(316, 441);
    curveVertex(310, 439);
    curveVertex(297, 437);
    curveVertex(297, 437);
    vertex(297, 437);
    vertex(254, 436);
    endShape();
    popMatrix();
    //rightleg
    fill(#2E3A83);
    beginShape();
    vertex(288, 305);
    vertex(311, 340);
    vertex(337, 338);
    vertex(314, 272);
    vertex(288, 305);
    endShape();
    fill(#9CB285);
    beginShape();
    vertex(319, 340);
    vertex(320, 362);
    arc(320, 372, 15, 17, PI/3, 7*PI/4);
    endShape();
    beginShape();
    vertex(321, 380);
    vertex(333, 412);
    vertex(342, 410);
    vertex(330, 364);
    vertex(331, 339);
    vertex(319, 340);
    endShape();
    fill(#2E3A83);
    beginShape();
    vertex(320, 417);
    vertex(356, 407);
    vertex(358, 432);
    vertex(323, 432);
    vertex(320, 417);
    endShape();
    //rightshoe
    fill(#6F4314);
    beginShape();
    vertex(323, 432);
    vertex(320, 440);
    curveVertex(320, 440);
    curveVertex(320, 440);
    curveVertex(307, 442);
    curveVertex(293, 444);
    curveVertex(285, 455);
    curveVertex(285, 455);
    vertex(285, 455);
    vertex(359, 455);
    vertex(358, 432);
    vertex(323, 432);
    endShape();
    popMatrix();
    popMatrix();
  }
  void drawZombie() {
    pushMatrix();
    translate(posX, posY);
    scale(scal);
    translate(-306, -456);
    //head

    beginShape();
    fill(#9CB285);
    vertex(146, 112);
    vertex(139, 98);
    curveVertex(139, 98);
    curveVertex(139, 98);
    curveVertex(150, 97);
    curveVertex(161, 92);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(161, 77);
    curveVertex(150, 72);
    curveVertex(139, 78);
    curveVertex(139, 78);
    vertex(139, 78);
    vertex(136, 69);
    curveVertex(136, 69);
    curveVertex(136, 69);
    curveVertex(165, 48);
    curveVertex(206, 51);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(252, 94);
    curveVertex(256, 127);
    curveVertex(224, 150);
    curveVertex(224, 150);
    vertex(231, 146);
    vertex(233, 156);
    curveVertex(233, 156);
    curveVertex(233, 156);
    curveVertex(222, 162);
    curveVertex(211, 166);
    curveVertex(206, 165);
    curveVertex(206, 165);
    vertex(213, 156);
    vertex(206, 165);
    vertex(202.5, 169.5);
    vertex(202.5, 169.5);
    vertex(183, 176);
    vertex(163, 176);
    curveVertex(163, 176);
    curveVertex(163, 176);
    curveVertex(159, 173);
    curveVertex(159, 171);
    curveVertex(159, 167);
    curveVertex(159, 167);
    curveVertex(166, 167);
    curveVertex(166, 167);
    curveVertex(159, 167);
    curveVertex(150, 165);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(156, 156);
    curveVertex(164, 150);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(167, 144);
    curveVertex(167, 130);
    curveVertex(165, 119);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape(CLOSE);
    beginShape();
    curveVertex(160, 59);
    curveVertex(160, 59);
    curveVertex(169, 64);
    curveVertex(178, 65);
    curveVertex(189, 60);
    curveVertex(189, 60);
    endShape();
    beginShape();
    noFill();
    curveVertex(156, 64);
    curveVertex(156, 64);
    curveVertex(166, 69);
    curveVertex(179, 70);
    curveVertex(194, 65);
    curveVertex(194, 65);
    endShape();
    beginShape();
    noFill();
    curveVertex(167, 56);
    curveVertex(167, 56);
    curveVertex(171, 59);
    curveVertex(176, 59);
    curveVertex(180, 57);
    curveVertex(180, 57);
    endShape();
    beginShape();
    noFill();
    vertex(204, 156);
    vertex(200, 162);
    vertex(192, 162);
    endShape();
    beginShape();
    noFill();
    vertex(215, 144);
    vertex(225, 137);
    vertex(226, 126);
    vertex(234, 119);
    endShape();
    //mouth
    fill(#5D0B1E);
    beginShape();
    vertex(146, 112);
    vertex(185, 112);
    curveVertex(185, 110);
    curveVertex(185, 110);
    curveVertex(201, 126);
    curveVertex(199, 148);
    curveVertex(195, 157);
    curveVertex(195, 157);
    vertex(195, 157);
    vertex(155, 157);
    curveVertex(155, 157);
    curveVertex(155, 157);
    curveVertex(160, 153);
    curveVertex(163, 127);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape();
    //outsideeye
    fill(#F0E8E6);
    ellipse(149, 84, 25, 25);
    fill(0);
    ellipse(148, 83, 4, 4);
    //innereye
    fill(#F0E8E6);
    ellipse(212, 82, 40, 40);
    fill(0);
    ellipse(215, 81, 4, 4);
    //hair
    beginShape();
    noFill();
    curveVertex(147, 59);
    curveVertex(147, 59);
    curveVertex(143, 53);
    curveVertex(139, 48);
    curveVertex(129, 46);
    curveVertex(129, 46);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(160, 41);
    curveVertex(165, 34);
    curveVertex(172, 30);
    curveVertex(172, 30);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(155, 43);
    curveVertex(156, 36);
    curveVertex(168, 36);
    curveVertex(168, 36);
    endShape();
    beginShape();
    curveVertex(190, 48);
    curveVertex(190, 48);
    curveVertex(191, 42);
    curveVertex(196, 36);
    curveVertex(207, 35);
    curveVertex(207, 35);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(233, 63);
    curveVertex(233, 55);
    curveVertex(232, 51);
    curveVertex(232, 51);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(237, 63);
    curveVertex(238, 59);
    curveVertex(241, 55);
    curveVertex(241, 55);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(238, 68);
    curveVertex(243, 67);
    curveVertex(249, 68);
    curveVertex(249, 68);
    endShape();
    beginShape();
    noFill();
    curveVertex(253, 107);
    curveVertex(253, 107);
    curveVertex(259, 106);
    curveVertex(265, 106);
    curveVertex(270, 110);
    curveVertex(270, 110);
    endShape();
    beginShape();
    noFill();
    curveVertex(254, 111);
    curveVertex(254, 111);
    curveVertex(259, 111);
    curveVertex(264, 111);
    curveVertex(268, 115);
    curveVertex(268, 115);
    endShape();
    beginShape();
    noFill();
    curveVertex(251, 96);
    curveVertex(251, 96);
    curveVertex(257, 95);
    curveVertex(264, 95);
    curveVertex(271, 100);
    curveVertex(271, 100);
    endShape();
    //noseholes
    fill(0);
    ellipse(170, 99, 5, 10);
    ellipse( 181, 99, 6, 12);
    //teeth
    fill(255);
    rect(161, 112, 12, 10);
    rect(177, 112, 8, 8);
    rect(163, 152, 8, 5);
    rect(182, 150, 8, 7);
    //leftarm
    beginShape();
    fill(#6F4314);
    vertex(183, 176);
    vertex(177, 182);
    vertex(177, 249);
    vertex(160, 272);
    vertex(151, 275);
    vertex(151, 300);
    vertex(200, 300);
    vertex(200, 275);
    endShape();
    line(151, 275, 200, 275);
    //lefthand
    fill(#9CB285);
    beginShape();
    curveVertex(157, 301);
    curveVertex(157, 301);
    curveVertex(155, 315);
    curveVertex(153, 327);
    curveVertex(157, 333);
    curveVertex(157, 333);
    curveVertex(163, 334);
    curveVertex(167, 333);
    curveVertex(167, 331);
    curveVertex(167, 331);
    vertex(167, 331);
    vertex(163, 323);
    vertex(164, 318);
    curveVertex(167, 331);
    curveVertex(167, 331);
    curveVertex(172, 333);
    curveVertex(175, 333);
    curveVertex(176, 330);
    curveVertex(176, 330);
    vertex(176, 330);
    vertex(172, 322);
    vertex(173, 319);
    curveVertex(176, 330);
    curveVertex(176, 330);
    curveVertex(182, 329);
    curveVertex(185, 328);
    curveVertex(185, 324);
    curveVertex(185, 324);
    vertex(185, 324);
    vertex(182, 318);
    vertex(183, 313);
    curveVertex(185, 324);
    curveVertex(185, 324);
    curveVertex(190, 327);
    curveVertex(192, 324);
    curveVertex(192, 321);
    curveVertex(192, 321);
    vertex(192, 321);
    vertex(190, 314);
    curveVertex(190, 314);
    curveVertex(190, 314);
    curveVertex(194, 312);
    curveVertex(195, 308);
    curveVertex(191, 301);
    curveVertex(191, 301);
    vertex(191, 301);
    vertex(158, 301);
    curveVertex(156, 309);
    curveVertex(156, 309);
    curveVertex(162, 315);
    curveVertex(166, 312);
    curveVertex(165, 304);
    curveVertex(165, 304);
    endShape();
    ellipse(161, 309, 4, 4);

    //suit
    fill(#6F4314);
    beginShape();
    vertex(193, 174);
    vertex(192, 217);
    vertex(200, 275);
    fill(#BC8B55);
    vertex(214, 311);
    vertex(204, 216);
    vertex(202, 169);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(182, 177);
    vertex(192, 174);
    vertex(192, 197);
    vertex(187, 201);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 170);
    vertex(232, 156);
    vertex(224, 162);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 173);
    vertex(222, 178);
    vertex(205, 229);
    vertex(205, 233);
    vertex(232, 278);
    vertex(246, 245);
    vertex(237, 224);
    vertex(243, 175);
    vertex(234, 181);
    vertex(228, 173);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(270, 279);
    vertex(259, 302);
    vertex(286, 303);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(258, 303);
    vertex(263, 306);
    vertex(256, 326);
    vertex(286, 304);
    vertex(258, 303);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(202, 169);
    vertex(208, 177);
    vertex(203, 184);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 172);
    vertex(234, 182);
    vertex(244, 174);
    vertex(248, 151);
    vertex(234, 155);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(207, 238);
    vertex(215, 309);
    vertex(224, 288);
    vertex(228, 290);
    vertex(232, 280);
    vertex(207, 238);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(244, 174);
    vertex(237, 224);
    vertex(247, 246);
    vertex(263, 210);
    vertex(248, 151);
    endShape();
    fill(#DED1C3);
    beginShape();
    vertex(205, 235);
    vertex(232, 280);
    endShape();
    //rightcoat
    fill(#6F4314);
    beginShape();
    curveVertex(248, 151);
    curveVertex(248, 151);
    curveVertex(293, 161);
    curveVertex(310, 200);
    curveVertex(314, 250);
    curveVertex(314, 250);
    vertex(314, 250);
    vertex(314, 270);
    vertex(288, 306);
    vertex(270, 278);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(270, 278);
    vertex(278, 262);
    vertex(288, 305);
    endShape();
    //rightarm
    fill(#6F4314);
    beginShape();
    vertex(269, 197);
    vertex(264, 210);
    vertex(247, 246);
    vertex(228, 291);
    vertex(257, 304);
    vertex(297, 223);
    endShape();
    beginShape();
    vertex(224, 289);
    vertex(263, 307);
    vertex(254, 330);
    vertex(214, 311);
    vertex(224, 289);
    endShape();
    //righthand
    fill(#9CB285);
    beginShape();
    vertex(219, 314);
    vertex(219, 328);
    vertex(213, 339);
    vertex(210, 348);
    curveVertex(210, 348);
    curveVertex(210, 348);
    curveVertex(211, 356);
    curveVertex(216, 359);
    curveVertex(220, 351);
    curveVertex(220, 351);
    vertex(220, 351);
    vertex(220, 342);
    vertex(225, 335);
    vertex(227, 346);
    vertex(233, 355);
    curveVertex(233, 355);
    curveVertex(233, 355);
    curveVertex(237, 358);
    curveVertex(241, 359);
    curveVertex(242, 355);
    curveVertex(242, 355);
    vertex(242, 355);
    vertex(235, 345);
    vertex(235, 337);
    curveVertex(242, 355);
    curveVertex(242, 355);
    curveVertex(246, 357);
    curveVertex(247, 355);
    curveVertex(248, 352);
    curveVertex(248, 352);
    vertex(248, 352);
    vertex(244, 344);
    vertex(245, 339);
    vertex(250, 352);
    curveVertex(250, 352);
    curveVertex(250, 352);
    curveVertex(253, 353);
    curveVertex(256, 352);
    curveVertex(257, 349);
    curveVertex(257, 349);
    vertex(257, 349);
    vertex(250, 335);
    vertex(249, 329);
    endShape();
    ellipse(214, 352, 4, 4);
    ellipse(238, 355, 3, 3);
    //tie
    fill(#B91831);
    beginShape();
    vertex(202, 169);
    vertex(209, 178);
    vertex(221, 178);
    vertex(228, 172);
    vertex(223, 162);
    endShape();
    beginShape();
    vertex(209, 178);
    vertex(168, 226);
    vertex(176, 280);
    vertex(209, 228);
    vertex(221, 178);
    endShape();
    //tiestripes
    line(205, 183, 218, 190);
    line(195, 195, 214, 203);
    line(184, 207, 210, 220);
    line(168, 226, 202, 238);
    line(174, 258, 188, 260);
    //jeans
    //leftleg
    pushMatrix();
    translate(254, 330);
    rotate(leftleg);
    translate(-254, -330);
    fill(#2E3A83);
    beginShape();
    vertex(254, 330);
    vertex(276, 388);
    vertex(254, 436);
    vertex(297, 437);
    vertex(309, 390);
    vertex(288, 305);
    vertex(254, 330);
    endShape();
    //leftshoe
    fill(#6F4314);
    beginShape();
    vertex(254, 436);
    vertex(250, 452);
    vertex(320, 454);
    curveVertex(320, 454);
    curveVertex(320, 454);
    curveVertex(316, 441);
    curveVertex(310, 439);
    curveVertex(297, 437);
    curveVertex(297, 437);
    vertex(297, 437);
    vertex(254, 436);
    endShape();
    popMatrix();
    //rightleg
    fill(#2E3A83);
    beginShape();
    vertex(288, 305);
    vertex(311, 340);
    vertex(337, 338);
    vertex(314, 272);
    vertex(288, 305);
    endShape();
    fill(#9CB285);
    beginShape();
    vertex(319, 340);
    vertex(320, 362);
    arc(320, 372, 15, 17, PI/3, 7*PI/4);
    endShape();
    beginShape();
    vertex(321, 380);
    vertex(333, 412);
    vertex(342, 410);
    vertex(330, 364);
    vertex(331, 339);
    vertex(319, 340);
    endShape();
    fill(#2E3A83);
    beginShape();
    vertex(320, 417);
    vertex(356, 407);
    vertex(358, 432);
    vertex(323, 432);
    vertex(320, 417);
    endShape();
    //rightshoe
    fill(#6F4314);
    beginShape();
    vertex(323, 432);
    vertex(320, 440);
    curveVertex(320, 440);
    curveVertex(320, 440);
    curveVertex(307, 442);
    curveVertex(293, 444);
    curveVertex(285, 455);
    curveVertex(285, 455);
    vertex(285, 455);
    vertex(359, 455);
    vertex(358, 432);
    vertex(323, 432);
    endShape();
    popMatrix();
  }
  void drawBucketZombie() {
    pushMatrix();
    translate(posX, posY);
    scale(scal);
    translate(-306, -456);
    drawZombie();
    pushMatrix();
    translate(posX, posY);
    scale(scal);
    translate(-306, -456);
    //head
    beginShape();
    fill(#9CB285);
    vertex(146, 112);
    vertex(139, 98);
    curveVertex(139, 98);
    curveVertex(139, 98);
    curveVertex(150, 97);
    curveVertex(161, 92);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(161, 77);
    curveVertex(150, 72);
    curveVertex(139, 78);
    curveVertex(139, 78);
    vertex(139, 78);
    vertex(136, 69);
    curveVertex(136, 69);
    curveVertex(136, 69);
    curveVertex(165, 48);
    curveVertex(206, 51);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(252, 94);
    curveVertex(256, 127);
    curveVertex(224, 150);
    curveVertex(224, 150);
    vertex(231, 146);
    vertex(233, 156);
    curveVertex(233, 156);
    curveVertex(233, 156);
    curveVertex(222, 162);
    curveVertex(211, 166);
    curveVertex(206, 165);
    curveVertex(206, 165);
    vertex(213, 156);
    vertex(206, 165);
    vertex(202.5, 169.5);
    vertex(202.5, 169.5);
    vertex(183, 176);
    vertex(163, 176);
    curveVertex(163, 176);
    curveVertex(163, 176);
    curveVertex(159, 173);
    curveVertex(159, 171);
    curveVertex(159, 167);
    curveVertex(159, 167);
    curveVertex(166, 167);
    curveVertex(166, 167);
    curveVertex(159, 167);
    curveVertex(150, 165);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(156, 156);
    curveVertex(164, 150);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(167, 144);
    curveVertex(167, 130);
    curveVertex(165, 119);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape(CLOSE);
    beginShape();
    curveVertex(160, 59);
    curveVertex(160, 59);
    curveVertex(169, 64);
    curveVertex(178, 65);
    curveVertex(189, 60);
    curveVertex(189, 60);
    endShape();
    beginShape();
    noFill();
    curveVertex(156, 64);
    curveVertex(156, 64);
    curveVertex(166, 69);
    curveVertex(179, 70);
    curveVertex(194, 65);
    curveVertex(194, 65);
    endShape();
    beginShape();
    noFill();
    curveVertex(167, 56);
    curveVertex(167, 56);
    curveVertex(171, 59);
    curveVertex(176, 59);
    curveVertex(180, 57);
    curveVertex(180, 57);
    endShape();
    beginShape();
    noFill();
    vertex(204, 156);
    vertex(200, 162);
    vertex(192, 162);
    endShape();
    beginShape();
    noFill();
    vertex(215, 144);
    vertex(225, 137);
    vertex(226, 126);
    vertex(234, 119);
    endShape();
    //mouth
    fill(#5D0B1E);
    beginShape();
    vertex(146, 112);
    vertex(185, 112);
    curveVertex(185, 110);
    curveVertex(185, 110);
    curveVertex(201, 126);
    curveVertex(199, 148);
    curveVertex(195, 157);
    curveVertex(195, 157);
    vertex(195, 157);
    vertex(155, 157);
    curveVertex(155, 157);
    curveVertex(155, 157);
    curveVertex(160, 153);
    curveVertex(163, 127);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape();
    //outsideeye
    fill(#F0E8E6);
    ellipse(149, 84, 25, 25);
    fill(0);
    ellipse(148, 83, 4, 4);
    //innereye
    fill(#F0E8E6);
    ellipse(212, 82, 40, 40);
    fill(0);
    ellipse(215, 81, 4, 4);
    //hair
    beginShape();
    noFill();
    curveVertex(147, 59);
    curveVertex(147, 59);
    curveVertex(143, 53);
    curveVertex(139, 48);
    curveVertex(129, 46);
    curveVertex(129, 46);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(160, 41);
    curveVertex(165, 34);
    curveVertex(172, 30);
    curveVertex(172, 30);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(155, 43);
    curveVertex(156, 36);
    curveVertex(168, 36);
    curveVertex(168, 36);
    endShape();
    beginShape();
    curveVertex(190, 48);
    curveVertex(190, 48);
    curveVertex(191, 42);
    curveVertex(196, 36);
    curveVertex(207, 35);
    curveVertex(207, 35);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(233, 63);
    curveVertex(233, 55);
    curveVertex(232, 51);
    curveVertex(232, 51);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(237, 63);
    curveVertex(238, 59);
    curveVertex(241, 55);
    curveVertex(241, 55);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(238, 68);
    curveVertex(243, 67);
    curveVertex(249, 68);
    curveVertex(249, 68);
    endShape();
    beginShape();
    noFill();
    curveVertex(253, 107);
    curveVertex(253, 107);
    curveVertex(259, 106);
    curveVertex(265, 106);
    curveVertex(270, 110);
    curveVertex(270, 110);
    endShape();
    beginShape();
    noFill();
    curveVertex(254, 111);
    curveVertex(254, 111);
    curveVertex(259, 111);
    curveVertex(264, 111);
    curveVertex(268, 115);
    curveVertex(268, 115);
    endShape();
    beginShape();
    noFill();
    curveVertex(251, 96);
    curveVertex(251, 96);
    curveVertex(257, 95);
    curveVertex(264, 95);
    curveVertex(271, 100);
    curveVertex(271, 100);
    endShape();
    //noseholes
    fill(0);
    ellipse(170, 99, 5, 10);
    ellipse( 181, 99, 6, 12);
    //teeth
    fill(255);
    rect(161, 112, 12, 10);
    rect(177, 112, 8, 8);
    rect(163, 152, 8, 5);
    rect(182, 150, 8, 7);
    //leftarm
    beginShape();
    fill(#6F4314);
    vertex(183, 176);
    vertex(177, 182);
    vertex(177, 249);
    vertex(160, 272);
    vertex(151, 275);
    vertex(151, 300);
    vertex(200, 300);
    vertex(200, 275);
    endShape();
    line(151, 275, 200, 275);
    //lefthand
    fill(#9CB285);
    beginShape();
    curveVertex(157, 301);
    curveVertex(157, 301);
    curveVertex(155, 315);
    curveVertex(153, 327);
    curveVertex(157, 333);
    curveVertex(157, 333);
    curveVertex(163, 334);
    curveVertex(167, 333);
    curveVertex(167, 331);
    curveVertex(167, 331);
    vertex(167, 331);
    vertex(163, 323);
    vertex(164, 318);
    curveVertex(167, 331);
    curveVertex(167, 331);
    curveVertex(172, 333);
    curveVertex(175, 333);
    curveVertex(176, 330);
    curveVertex(176, 330);
    vertex(176, 330);
    vertex(172, 322);
    vertex(173, 319);
    curveVertex(176, 330);
    curveVertex(176, 330);
    curveVertex(182, 329);
    curveVertex(185, 328);
    curveVertex(185, 324);
    curveVertex(185, 324);
    vertex(185, 324);
    vertex(182, 318);
    vertex(183, 313);
    curveVertex(185, 324);
    curveVertex(185, 324);
    curveVertex(190, 327);
    curveVertex(192, 324);
    curveVertex(192, 321);
    curveVertex(192, 321);
    vertex(192, 321);
    vertex(190, 314);
    curveVertex(190, 314);
    curveVertex(190, 314);
    curveVertex(194, 312);
    curveVertex(195, 308);
    curveVertex(191, 301);
    curveVertex(191, 301);
    vertex(191, 301);
    vertex(158, 301);
    curveVertex(156, 309);
    curveVertex(156, 309);
    curveVertex(162, 315);
    curveVertex(166, 312);
    curveVertex(165, 304);
    curveVertex(165, 304);
    endShape();
    ellipse(161, 309, 4, 4);

    //suit
    fill(#6F4314);
    beginShape();
    vertex(193, 174);
    vertex(192, 217);
    vertex(200, 275);
    fill(#BC8B55);
    vertex(214, 311);
    vertex(204, 216);
    vertex(202, 169);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(182, 177);
    vertex(192, 174);
    vertex(192, 197);
    vertex(187, 201);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 170);
    vertex(232, 156);
    vertex(224, 162);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 173);
    vertex(222, 178);
    vertex(205, 229);
    vertex(205, 233);
    vertex(232, 278);
    vertex(246, 245);
    vertex(237, 224);
    vertex(243, 175);
    vertex(234, 181);
    vertex(228, 173);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(270, 279);
    vertex(259, 302);
    vertex(286, 303);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(258, 303);
    vertex(263, 306);
    vertex(256, 326);
    vertex(286, 304);
    vertex(258, 303);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(202, 169);
    vertex(208, 177);
    vertex(203, 184);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 172);
    vertex(234, 182);
    vertex(244, 174);
    vertex(248, 151);
    vertex(234, 155);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(207, 238);
    vertex(215, 309);
    vertex(224, 288);
    vertex(228, 290);
    vertex(232, 280);
    vertex(207, 238);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(244, 174);
    vertex(237, 224);
    vertex(247, 246);
    vertex(263, 210);
    vertex(248, 151);
    endShape();
    fill(#DED1C3);
    beginShape();
    vertex(205, 235);
    vertex(232, 280);
    endShape();
    //rightcoat
    fill(#6F4314);
    beginShape();
    curveVertex(248, 151);
    curveVertex(248, 151);
    curveVertex(293, 161);
    curveVertex(310, 200);
    curveVertex(314, 250);
    curveVertex(314, 250);
    vertex(314, 250);
    vertex(314, 270);
    vertex(288, 306);
    vertex(270, 278);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(270, 278);
    vertex(278, 262);
    vertex(288, 305);
    endShape();
    //rightarm
    fill(#6F4314);
    beginShape();
    vertex(269, 197);
    vertex(264, 210);
    vertex(247, 246);
    vertex(228, 291);
    vertex(257, 304);
    vertex(297, 223);
    endShape();
    beginShape();
    vertex(224, 289);
    vertex(263, 307);
    vertex(254, 330);
    vertex(214, 311);
    vertex(224, 289);
    endShape();
    //righthand
    fill(#9CB285);
    beginShape();
    vertex(219, 314);
    vertex(219, 328);
    vertex(213, 339);
    vertex(210, 348);
    curveVertex(210, 348);
    curveVertex(210, 348);
    curveVertex(211, 356);
    curveVertex(216, 359);
    curveVertex(220, 351);
    curveVertex(220, 351);
    vertex(220, 351);
    vertex(220, 342);
    vertex(225, 335);
    vertex(227, 346);
    vertex(233, 355);
    curveVertex(233, 355);
    curveVertex(233, 355);
    curveVertex(237, 358);
    curveVertex(241, 359);
    curveVertex(242, 355);
    curveVertex(242, 355);
    vertex(242, 355);
    vertex(235, 345);
    vertex(235, 337);
    curveVertex(242, 355);
    curveVertex(242, 355);
    curveVertex(246, 357);
    curveVertex(247, 355);
    curveVertex(248, 352);
    curveVertex(248, 352);
    vertex(248, 352);
    vertex(244, 344);
    vertex(245, 339);
    vertex(250, 352);
    curveVertex(250, 352);
    curveVertex(250, 352);
    curveVertex(253, 353);
    curveVertex(256, 352);
    curveVertex(257, 349);
    curveVertex(257, 349);
    vertex(257, 349);
    vertex(250, 335);
    vertex(249, 329);
    endShape();
    ellipse(214, 352, 4, 4);
    ellipse(238, 355, 3, 3);
    //tie
    fill(#B91831);
    beginShape();
    vertex(202, 169);
    vertex(209, 178);
    vertex(221, 178);
    vertex(228, 172);
    vertex(223, 162);
    endShape();
    beginShape();
    vertex(209, 178);
    vertex(168, 226);
    vertex(176, 280);
    vertex(209, 228);
    vertex(221, 178);
    endShape();
    //tiestripes
    line(205, 183, 218, 190);
    line(195, 195, 214, 203);
    line(184, 207, 210, 220);
    line(168, 226, 202, 238);
    line(174, 258, 188, 260);
    //jeans
    //leftleg
    fill(#2E3A83);
    beginShape();
    vertex(254, 330);
    vertex(276, 388);
    vertex(254, 436);
    vertex(297, 437);
    vertex(309, 390);
    vertex(288, 305);
    vertex(254, 330);
    endShape();
    //leftshoe
    fill(#6F4314);
    beginShape();
    vertex(254, 436);
    vertex(250, 452);
    vertex(320, 454);
    curveVertex(320, 454);
    curveVertex(320, 454);
    curveVertex(316, 441);
    curveVertex(310, 439);
    curveVertex(297, 437);
    curveVertex(297, 437);
    vertex(297, 437);
    vertex(254, 436);
    endShape();
    //rightleg
    fill(#2E3A83);
    beginShape();
    vertex(288, 305);
    vertex(311, 340);
    vertex(337, 338);
    vertex(314, 272);
    vertex(288, 305);
    endShape();
    fill(#9CB285);
    beginShape();
    vertex(319, 340);
    vertex(320, 362);
    arc(320, 372, 15, 17, PI/3, 7*PI/4);
    endShape();
    beginShape();
    vertex(321, 380);
    vertex(333, 412);
    vertex(342, 410);
    vertex(330, 364);
    vertex(331, 339);
    vertex(319, 340);
    endShape();
    fill(#2E3A83);
    beginShape();
    vertex(320, 417);
    vertex(356, 407);
    vertex(358, 432);
    vertex(323, 432);
    vertex(320, 417);
    endShape();
    //rightshoe
    fill(#6F4314);
    beginShape();
    vertex(323, 432);
    vertex(320, 440);
    curveVertex(320, 440);
    curveVertex(320, 440);
    curveVertex(307, 442);
    curveVertex(293, 444);
    curveVertex(285, 455);
    curveVertex(285, 455);
    vertex(285, 455);
    vertex(359, 455);
    vertex(358, 432);
    vertex(323, 432);
    endShape();
    //bucket
    fill(#CBC5C5);
    beginShape();
    curveVertex(147, 57);
    curveVertex(147, 57);
    curveVertex(182, 77);
    curveVertex(221, 85);
    curveVertex(254, 85);
    curveVertex(254, 85);
    curveVertex(254, 85);
    curveVertex(254, 85);
    curveVertex(258, 83);
    curveVertex(259, 80);
    curveVertex(256, 76);
    curveVertex(256, 76);
    curveVertex(256, 76);
    curveVertex(256, 76);
    curveVertex(221, 78);
    curveVertex(182, 71);
    curveVertex(148, 49);
    curveVertex(148, 49);
    curveVertex(148, 49);
    curveVertex(148, 49);
    curveVertex(146, 51);
    curveVertex(145, 54);
    curveVertex(147, 57);
    curveVertex(147, 57);
    endShape();
    beginShape();
    vertex(150, 50);
    vertex(184, 2);
    curveVertex(184, 2);
    curveVertex(184, 2);
    curveVertex(200, 8);
    curveVertex(227, 13);
    curveVertex(254, 14);
    curveVertex(254, 14);
    vertex(249, 75);
    curveVertex(249, 75);
    curveVertex(249, 75);
    curveVertex(221, 78);
    curveVertex(182, 71);
    curveVertex(150, 50);
    curveVertex(150, 50);
    endShape();
    fill(#DED7D7);
    beginShape();
    curveVertex(184, 2);
    curveVertex(184, 2);
    curveVertex(200, 8);
    curveVertex(227, 13);
    curveVertex(254, 14);
    curveVertex(254, 14);
    curveVertex(254, 14);
    curveVertex(254, 14);
    curveVertex(231, 2);
    curveVertex(200, 0);
    curveVertex(184, 2);
    curveVertex(184, 2);
    endShape();
    fill(#B2ABAB);
    ellipse(244, 71, 22, 22);
    fill(#6F6767);
    ellipse(248, 70, 22, 22);
    fill(#897D7D);
    beginShape();
    curveVertex(245, 75);
    curveVertex(245, 75);
    curveVertex(245, 71);
    curveVertex(248, 69);
    curveVertex(258, 75);
    curveVertex(258, 75);
    vertex(185, 154);
    vertex(114, 74);
    vertex(144, 56);
    vertex(148, 61);
    vertex(125, 76);
    vertex(186, 140);
    vertex(245, 75);
    endShape();
    popMatrix();
  }

  void drawConeZombie() {
    pushMatrix();
    translate(posX, posY);
    scale(scal);
    translate(-306, -456);
    //head
    beginShape();
    fill(#9CB285);
    vertex(146, 112);
    vertex(139, 98);
    curveVertex(139, 98);
    curveVertex(139, 98);
    curveVertex(150, 97);
    curveVertex(161, 92);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(163, 85);
    curveVertex(161, 77);
    curveVertex(150, 72);
    curveVertex(139, 78);
    curveVertex(139, 78);
    vertex(139, 78);
    vertex(136, 69);
    curveVertex(136, 69);
    curveVertex(136, 69);
    curveVertex(165, 48);
    curveVertex(206, 51);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(233, 68);
    curveVertex(252, 94);
    curveVertex(256, 127);
    curveVertex(224, 150);
    curveVertex(224, 150);
    vertex(231, 146);
    vertex(233, 156);
    curveVertex(233, 156);
    curveVertex(233, 156);
    curveVertex(222, 162);
    curveVertex(211, 166);
    curveVertex(206, 165);
    curveVertex(206, 165);
    vertex(213, 156);
    vertex(206, 165);
    vertex(202.5, 169.5);
    vertex(202.5, 169.5);
    vertex(183, 176);
    vertex(163, 176);
    curveVertex(163, 176);
    curveVertex(163, 176);
    curveVertex(159, 173);
    curveVertex(159, 171);
    curveVertex(159, 167);
    curveVertex(159, 167);
    curveVertex(166, 167);
    curveVertex(166, 167);
    curveVertex(159, 167);
    curveVertex(150, 165);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(148, 160);
    curveVertex(156, 156);
    curveVertex(164, 150);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(166, 144);
    curveVertex(167, 144);
    curveVertex(167, 130);
    curveVertex(165, 119);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape(CLOSE);
    beginShape();
    curveVertex(160, 59);
    curveVertex(160, 59);
    curveVertex(169, 64);
    curveVertex(178, 65);
    curveVertex(189, 60);
    curveVertex(189, 60);
    endShape();
    beginShape();
    noFill();
    curveVertex(156, 64);
    curveVertex(156, 64);
    curveVertex(166, 69);
    curveVertex(179, 70);
    curveVertex(194, 65);
    curveVertex(194, 65);
    endShape();
    beginShape();
    noFill();
    curveVertex(167, 56);
    curveVertex(167, 56);
    curveVertex(171, 59);
    curveVertex(176, 59);
    curveVertex(180, 57);
    curveVertex(180, 57);
    endShape();
    beginShape();
    noFill();
    vertex(204, 156);
    vertex(200, 162);
    vertex(192, 162);
    endShape();
    beginShape();
    noFill();
    vertex(215, 144);
    vertex(225, 137);
    vertex(226, 126);
    vertex(234, 119);
    endShape();
    //mouth
    fill(#5D0B1E);
    beginShape();
    vertex(146, 112);
    vertex(185, 112);
    curveVertex(185, 110);
    curveVertex(185, 110);
    curveVertex(201, 126);
    curveVertex(199, 148);
    curveVertex(195, 157);
    curveVertex(195, 157);
    vertex(195, 157);
    vertex(155, 157);
    curveVertex(155, 157);
    curveVertex(155, 157);
    curveVertex(160, 153);
    curveVertex(163, 127);
    curveVertex(146, 112);
    curveVertex(146, 112);
    endShape();
    //outsideeye
    fill(#F0E8E6);
    ellipse(149, 84, 25, 25);
    fill(0);
    ellipse(148, 83, 4, 4);
    //innereye
    fill(#F0E8E6);
    ellipse(212, 82, 40, 40);
    fill(0);
    ellipse(215, 81, 4, 4);
    //hair
    beginShape();
    noFill();
    curveVertex(147, 59);
    curveVertex(147, 59);
    curveVertex(143, 53);
    curveVertex(139, 48);
    curveVertex(129, 46);
    curveVertex(129, 46);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(160, 41);
    curveVertex(165, 34);
    curveVertex(172, 30);
    curveVertex(172, 30);
    endShape();
    beginShape();
    noFill();
    curveVertex(160, 49);
    curveVertex(160, 49);
    curveVertex(155, 43);
    curveVertex(156, 36);
    curveVertex(168, 36);
    curveVertex(168, 36);
    endShape();
    beginShape();
    curveVertex(190, 48);
    curveVertex(190, 48);
    curveVertex(191, 42);
    curveVertex(196, 36);
    curveVertex(207, 35);
    curveVertex(207, 35);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(233, 63);
    curveVertex(233, 55);
    curveVertex(232, 51);
    curveVertex(232, 51);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(237, 63);
    curveVertex(238, 59);
    curveVertex(241, 55);
    curveVertex(241, 55);
    endShape();
    beginShape();
    noFill();
    curveVertex(231, 69);
    curveVertex(231, 69);
    curveVertex(238, 68);
    curveVertex(243, 67);
    curveVertex(249, 68);
    curveVertex(249, 68);
    endShape();
    beginShape();
    noFill();
    curveVertex(253, 107);
    curveVertex(253, 107);
    curveVertex(259, 106);
    curveVertex(265, 106);
    curveVertex(270, 110);
    curveVertex(270, 110);
    endShape();
    beginShape();
    noFill();
    curveVertex(254, 111);
    curveVertex(254, 111);
    curveVertex(259, 111);
    curveVertex(264, 111);
    curveVertex(268, 115);
    curveVertex(268, 115);
    endShape();
    beginShape();
    noFill();
    curveVertex(251, 96);
    curveVertex(251, 96);
    curveVertex(257, 95);
    curveVertex(264, 95);
    curveVertex(271, 100);
    curveVertex(271, 100);
    endShape();
    //noseholes
    fill(0);
    ellipse(170, 99, 5, 10);
    ellipse( 181, 99, 6, 12);
    //teeth
    fill(255);
    rect(161, 112, 12, 10);
    rect(177, 112, 8, 8);
    rect(163, 152, 8, 5);
    rect(182, 150, 8, 7);
    popMatrix();
    //leftarm
    beginShape();
    fill(#6F4314);
    vertex(183, 176);
    vertex(177, 182);
    vertex(177, 249);
    vertex(160, 272);
    vertex(151, 275);
    vertex(151, 300);
    vertex(200, 300);
    vertex(200, 275);
    endShape();
    line(151, 275, 200, 275);
    //lefthand
    fill(#9CB285);
    beginShape();
    curveVertex(157, 301);
    curveVertex(157, 301);
    curveVertex(155, 315);
    curveVertex(153, 327);
    curveVertex(157, 333);
    curveVertex(157, 333);
    curveVertex(163, 334);
    curveVertex(167, 333);
    curveVertex(167, 331);
    curveVertex(167, 331);
    vertex(167, 331);
    vertex(163, 323);
    vertex(164, 318);
    curveVertex(167, 331);
    curveVertex(167, 331);
    curveVertex(172, 333);
    curveVertex(175, 333);
    curveVertex(176, 330);
    curveVertex(176, 330);
    vertex(176, 330);
    vertex(172, 322);
    vertex(173, 319);
    curveVertex(176, 330);
    curveVertex(176, 330);
    curveVertex(182, 329);
    curveVertex(185, 328);
    curveVertex(185, 324);
    curveVertex(185, 324);
    vertex(185, 324);
    vertex(182, 318);
    vertex(183, 313);
    curveVertex(185, 324);
    curveVertex(185, 324);
    curveVertex(190, 327);
    curveVertex(192, 324);
    curveVertex(192, 321);
    curveVertex(192, 321);
    vertex(192, 321);
    vertex(190, 314);
    curveVertex(190, 314);
    curveVertex(190, 314);
    curveVertex(194, 312);
    curveVertex(195, 308);
    curveVertex(191, 301);
    curveVertex(191, 301);
    vertex(191, 301);
    vertex(158, 301);
    curveVertex(156, 309);
    curveVertex(156, 309);
    curveVertex(162, 315);
    curveVertex(166, 312);
    curveVertex(165, 304);
    curveVertex(165, 304);
    endShape();
    ellipse(161, 309, 4, 4);

    //suit
    fill(#6F4314);
    beginShape();
    vertex(193, 174);
    vertex(192, 217);
    vertex(200, 275);
    fill(#BC8B55);
    vertex(214, 311);
    vertex(204, 216);
    vertex(202, 169);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(182, 177);
    vertex(192, 174);
    vertex(192, 197);
    vertex(187, 201);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 170);
    vertex(232, 156);
    vertex(224, 162);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 173);
    vertex(222, 178);
    vertex(205, 229);
    vertex(205, 233);
    vertex(232, 278);
    vertex(246, 245);
    vertex(237, 224);
    vertex(243, 175);
    vertex(234, 181);
    vertex(228, 173);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(270, 279);
    vertex(259, 302);
    vertex(286, 303);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(258, 303);
    vertex(263, 306);
    vertex(256, 326);
    vertex(286, 304);
    vertex(258, 303);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(202, 169);
    vertex(208, 177);
    vertex(203, 184);
    endShape();
    fill(#D5D6E0);
    beginShape();
    vertex(228, 172);
    vertex(234, 182);
    vertex(244, 174);
    vertex(248, 151);
    vertex(234, 155);
    endShape();
    fill(#6F4314);
    beginShape();
    vertex(207, 238);
    vertex(215, 309);
    vertex(224, 288);
    vertex(228, 290);
    vertex(232, 280);
    vertex(207, 238);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(244, 174);
    vertex(237, 224);
    vertex(247, 246);
    vertex(263, 210);
    vertex(248, 151);
    endShape();
    fill(#DED1C3);
    beginShape();
    vertex(205, 235);
    vertex(232, 280);
    endShape();
    //rightcoat
    fill(#6F4314);
    beginShape();
    curveVertex(248, 151);
    curveVertex(248, 151);
    curveVertex(293, 161);
    curveVertex(310, 200);
    curveVertex(314, 250);
    curveVertex(314, 250);
    vertex(314, 250);
    vertex(314, 270);
    vertex(288, 306);
    vertex(270, 278);
    endShape();
    fill(#BC8B55);
    beginShape();
    vertex(270, 278);
    vertex(278, 262);
    vertex(288, 305);
    endShape();
    //rightarm
    fill(#6F4314);
    beginShape();
    vertex(269, 197);
    vertex(264, 210);
    vertex(247, 246);
    vertex(228, 291);
    vertex(257, 304);
    vertex(297, 223);
    endShape();
    beginShape();
    vertex(224, 289);
    vertex(263, 307);
    vertex(254, 330);
    vertex(214, 311);
    vertex(224, 289);
    endShape();
    //righthand
    fill(#9CB285);
    beginShape();
    vertex(219, 314);
    vertex(219, 328);
    vertex(213, 339);
    vertex(210, 348);
    curveVertex(210, 348);
    curveVertex(210, 348);
    curveVertex(211, 356);
    curveVertex(216, 359);
    curveVertex(220, 351);
    curveVertex(220, 351);
    vertex(220, 351);
    vertex(220, 342);
    vertex(225, 335);
    vertex(227, 346);
    vertex(233, 355);
    curveVertex(233, 355);
    curveVertex(233, 355);
    curveVertex(237, 358);
    curveVertex(241, 359);
    curveVertex(242, 355);
    curveVertex(242, 355);
    vertex(242, 355);
    vertex(235, 345);
    vertex(235, 337);
    curveVertex(242, 355);
    curveVertex(242, 355);
    curveVertex(246, 357);
    curveVertex(247, 355);
    curveVertex(248, 352);
    curveVertex(248, 352);
    vertex(248, 352);
    vertex(244, 344);
    vertex(245, 339);
    vertex(250, 352);
    curveVertex(250, 352);
    curveVertex(250, 352);
    curveVertex(253, 353);
    curveVertex(256, 352);
    curveVertex(257, 349);
    curveVertex(257, 349);
    vertex(257, 349);
    vertex(250, 335);
    vertex(249, 329);
    endShape();
    ellipse(214, 352, 4, 4);
    ellipse(238, 355, 3, 3);
    //tie
    fill(#B91831);
    beginShape();
    vertex(202, 169);
    vertex(209, 178);
    vertex(221, 178);
    vertex(228, 172);
    vertex(223, 162);
    endShape();
    beginShape();
    vertex(209, 178);
    vertex(168, 226);
    vertex(176, 280);
    vertex(209, 228);
    vertex(221, 178);
    endShape();
    //tiestripes
    line(205, 183, 218, 190);
    line(195, 195, 214, 203);
    line(184, 207, 210, 220);
    line(168, 226, 202, 238);
    line(174, 258, 188, 260);
    //jeans
    //leftleg
    fill(#2E3A83);
    pushMatrix();
    translate(254, 330);
    rotate(leftleg);
    translate(-254, -330);
    beginShape();
    vertex(254, 330);
    vertex(276, 388);
    vertex(254, 436);
    vertex(297, 437);
    vertex(309, 390);
    vertex(288, 305);
    vertex(254, 330);
    endShape();
    //leftshoe
    fill(#6F4314);
    beginShape();
    vertex(254, 436);
    vertex(250, 452);
    vertex(320, 454);
    curveVertex(320, 454);
    curveVertex(320, 454);
    curveVertex(316, 441);
    curveVertex(310, 439);
    curveVertex(297, 437);
    curveVertex(297, 437);
    vertex(297, 437);
    vertex(254, 436);
    endShape();
    popMatrix();
    //rightleg
    fill(#2E3A83);
    beginShape();
    vertex(288, 305);
    vertex(311, 340);
    vertex(337, 338);
    vertex(314, 272);
    vertex(288, 305);
    endShape();
    fill(#9CB285);
    beginShape();
    vertex(319, 340);
    vertex(320, 362);
    arc(320, 372, 15, 17, PI/3, 7*PI/4);
    endShape();
    beginShape();
    vertex(321, 380);
    vertex(333, 412);
    vertex(342, 410);
    vertex(330, 364);
    vertex(331, 339);
    vertex(319, 340);
    endShape();
    fill(#2E3A83);
    beginShape();
    vertex(320, 417);
    vertex(356, 407);
    vertex(358, 432);
    vertex(323, 432);
    vertex(320, 417);
    endShape();
    //rightshoe
    fill(#6F4314);
    beginShape();
    vertex(323, 432);
    vertex(320, 440);
    curveVertex(320, 440);
    curveVertex(320, 440);
    curveVertex(307, 442);
    curveVertex(293, 444);
    curveVertex(285, 455);
    curveVertex(285, 455);
    vertex(285, 455);
    vertex(359, 455);
    vertex(358, 432);
    vertex(323, 432);
    endShape();
    //cone
    fill(#F09C1D);
    beginShape();
    vertex(167, 40);
    vertex(219, 71);
    vertex(260, 67);
    vertex(248, 57);
    curveVertex(248, 57);
    curveVertex(248, 57);
    curveVertex(228, 54);
    curveVertex(199, 47);
    curveVertex(183, 38);
    curveVertex(183, 38);
    vertex(167, 40);
    endShape();
    beginShape();
    curveVertex(183, 38);
    curveVertex(183, 38);
    curveVertex(199, 47);
    curveVertex(228, 54);
    curveVertex(248, 57);
    curveVertex(248, 57);
    vertex(248, 57);
    vertex(242, 0);
    curveVertex(242, 0);
    curveVertex(242, 0);
    curveVertex(236, 2);
    curveVertex(228, 2);
    curveVertex(219, 0);
    curveVertex(219, 0);
    vertex(183, 38);
    endShape();
    fill(#CB8315);
    beginShape();
    curveVertex(219, 0);
    curveVertex(219, 0);
    curveVertex(228, 2);
    curveVertex(236, 2);
    curveVertex(242, 0);
    curveVertex(242, 0);
    curveVertex(242, 0);
    curveVertex(242, 0);
    curveVertex(236, -2);
    curveVertex(228, -2);
    curveVertex(219, 0);
    curveVertex(219, 0);
    endShape();
    popMatrix();
  }
  void update() {
    posX-=speed;
  }
}

class sunFlower {
  float posX;
  float posY;
  float  petalX;
  float  petalY;
  float radius;
  float theta=0;
  float scal;
  float currentX;
  float currentY;
  int framecount=0;
  sunFlower(float x, float y, float s) {
    posX=x;
    posY=y;
    scal=s;
  }
  
 void drawSF(){
  pushMatrix();
  translate(posX, posY);
  scale(scal);
  translate(-186, -316);
  fill(#2EBC36);
  //stem
  beginShape();
  curveVertex(184, 274);
  curveVertex(184, 274);
  curveVertex(176, 287);
  curveVertex(173, 301);
  curveVertex(178, 315);
  curveVertex(178, 315);
  vertex(178, 315);
  vertex(198, 315);
  curveVertex(198, 315);
  curveVertex(198, 315);
  curveVertex(197, 302);
  curveVertex(198, 294);
  curveVertex(208, 275);
  curveVertex(208, 275);
  endShape();
  //leaves
  beginShape();
  curveVertex(186, 313);
  curveVertex(186, 313);
  curveVertex(200, 295);
  curveVertex(226, 295);
  curveVertex(252, 305);
  curveVertex(252, 305);
  curveVertex(252, 305);
  curveVertex(252, 305);
  curveVertex(226, 325);
  curveVertex(200, 325);
  curveVertex(186, 318);
  curveVertex(186, 318);
  curveVertex(172, 325);
  curveVertex(146, 325);
  curveVertex(120, 305);
  curveVertex(120, 305);
  curveVertex(146, 295);
  curveVertex(172, 295);
  curveVertex(186, 313);
  curveVertex(186, 313);
  endShape();
  beginShape();
  curveVertex(200, 304);
  curveVertex(200, 304);
  curveVertex(203, 303);
  curveVertex(209, 301);
  curveVertex(218, 302);
  curveVertex(218, 302);
  endShape();
  beginShape();
  curveVertex(135, 305);
  curveVertex(135, 305);
  curveVertex(141, 303);
  curveVertex(148, 301);
  curveVertex(155, 301);
  curveVertex(155, 301);
  endShape();
  fill(#E5EA50);
  //petals
  ellipse(197, 117, 30, 30);
  ellipse(228, 119, 30, 30);
  ellipse(257, 128, 30, 30);
  ellipse(282, 145, 30, 30);
  ellipse(301, 168, 30, 30);
  ellipse(308, 197, 30, 30);
  ellipse(302, 227, 30, 30);
  ellipse(284, 251, 30, 30);
  ellipse(260, 269, 30, 30);
  ellipse(232, 281, 30, 30);
  ellipse(202, 284, 30, 30);
  ellipse(172, 280, 30, 30);
  ellipse(142, 272, 30, 30);
  ellipse(116, 256, 30, 30);
  ellipse(97, 233, 30, 30);
  ellipse(88, 204, 30, 30);
  ellipse(91, 174, 30, 30);
  ellipse(109, 149, 30, 30);
  ellipse(134, 131, 30, 30);
  ellipse(164, 120, 30, 30);
  fill(#A05B30);
  //face
  ellipse(200, 200, 200, 150);
  fill(0);
  ellipse(225, 180, 14, 40);
  ellipse(175, 180, 14, 40);
  fill(255);
  ellipse(173, 172, 4, 8);
  ellipse(223, 172, 4, 8);
  noFill();
  //smile
  beginShape();
  curveVertex(140, 219);
  curveVertex(140, 219);
  curveVertex(180, 240);
  curveVertex(228, 240);
  curveVertex(255, 219);
  curveVertex(255, 219);
  endShape();
  beginShape();
  curveVertex(139, 223);
  curveVertex(139, 223);
  curveVertex(140, 219);
  curveVertex(142, 216);
  curveVertex(147, 215);
  curveVertex(147, 215);
  endShape();
  beginShape();
  curveVertex(257, 222);
  curveVertex(257, 222);
  curveVertex(255, 219);
  curveVertex(253, 218);
  curveVertex(246, 216);
  curveVertex(246, 216);
  endShape();
  popMatrix();

}
  
  void update(){
    posX=mouseX;
    posY=mouseY;
    
  }
}

class sun {
  float posX, posY;
  float x, y;
  float radius, theta;
  int sunCount;
  String s;
  float scal;
  int framecount=0;
  sun(float x1, float y1, float sc) {
    posX=x1;
    posY=y1;
    sunCount=0;
    scal=sc;
  }
  void drawSun() {
    pushMatrix();
    noStroke();
    translate(posX,posY);
    scale(scal);
    translate(-posX,-posY);
    theta=0;
    fill(250, 252, 145);
    beginShape();
    for (int i=0; i<21; i++) {
      if (i%2==0) {
        radius=12;
        x=posX+(radius*cos(theta));
        y=posY+(radius*sin(theta));
        vertex(x, y);
        theta+=TWO_PI/20;
      } else {
        radius=24;
        x=posX+(radius*cos(theta));
        y=posY+(radius*sin(theta));
        vertex(x, y);
        theta+=TWO_PI/20;
      }
    }
    endShape();
    fill(252, 252, 222);
    ellipse(posX, posY, 24, 24);
    fill(251, 255, 41);
    ellipse(posX, posY, 20, 20);
    stroke(0,0,0);
    popMatrix();
  }

  void drawSC() {
    s=str(sunCount);
    fill(252,252,222);
    rect(posX-35, posY+30, 70, 30);
    fill(0,0,0);
    textAlign(CENTER);
    textSize(25);
    text(s, posX-35, posY+30, 70, 30);
  }
  
  void update(){
    posY+=1;
  }
}

class plant {
  float cx, cy;
  float scal;
  int plantType;
  int framecount=0;
  plant(float x, float y, float s) {
    cx=x;
    cy=y;
    scal=s;
  }

  void drawPeaShooter() {

    //noStroke();
    pushMatrix();
    smooth();
    translate(cx, cy);
    scale(scal);
    translate(-cx, -cy);
    fill(#1C9B2C); //topleaf
    beginShape();
    vertex(cx-60, cy+20);
    quadraticVertex(cx-50, cy-10, cx-30, cy);
    vertex(cx-60, cy+20);
    endShape();

    fill(#1C9B2C);
    //bottom leaves

    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();

    pushMatrix();
    translate(cx+2, cy+106);
    rotate(TWO_PI/6);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx, cy+110);
    rotate(TWO_PI/2);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx-4, cy+106);
    rotate(4*PI/3);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();



    fill(#1C9B2C);
    ellipse(cx, cy+50, 10, 120); //stem

    fill(#1C9B2C);
    ellipse(cx, cy+23, 20, 10); //stem attachment


    fill(#C1EA74);
    ellipse(cx, cy, 70, 45); //head 
    ellipse(cx+40, cy, 30, 60); //beak
    fill(#2C4D32);
    ellipse(cx+42, cy, 20, 40); //inner mouth
    ellipse(cx, cy-5, 10, 15); // outer eyes
    ellipse(cx+15, cy-10, 7, 12); //outer eyes
    fill(255);
    ellipse(cx-1, cy-6, 4, 6); //inner eyes
    ellipse(cx+14, cy-11, 3, 5); //inner eyes 

    popMatrix();
  }

  void drawRepeater() {
    //noStroke();
    pushMatrix();
    smooth();
    translate(cx, cy);
    scale(scal);
    translate(-cx, -cy);

    fill(#1C9B2C); //topleaf
    beginShape();
    vertex(cx-60, cy+20);
    quadraticVertex(cx-50, cy-10, cx-30, cy);
    vertex(cx-60, cy+20);
    endShape();

    pushMatrix();
    translate(cx-34, cy);
    rotate(3*PI/2);
    translate(-(cx-60), -(cy+20));
    beginShape();
    vertex(cx-60, cy+20);
    quadraticVertex(cx-50, cy-10, cx-30, cy);
    vertex(cx-60, cy+20);
    endShape();
    popMatrix();

    fill(#1C9B2C);
    fill(#1C9B2C);
    //bottom leaves

    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();

    pushMatrix();
    translate(cx+2, cy+106);
    rotate(TWO_PI/6);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx, cy+110);
    rotate(TWO_PI/2);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx-4, cy+106);
    rotate(4*PI/3);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();


    fill(#1C9B2C);
    ellipse(cx, cy+50, 10, 120); //stem

    fill(#1C9B2C);
    ellipse(cx, cy+23, 20, 10); //stem attachment


    fill(#C1EA74);
    ellipse(cx, cy, 70, 45); //head 
    ellipse(cx+40, cy, 30, 60); //beak
    fill(#2C4D32);
    ellipse(cx+42, cy, 20, 40); //inner mouth
    ellipse(cx, cy-5, 10, 15); // outer eyes
    ellipse(cx+15, cy-10, 7, 12); //outer eyes
    fill(255);
    ellipse(cx-1, cy-6, 4, 6); //inner eyes
    ellipse(cx+14, cy-11, 3, 5); //inner eyes 

    fill(#1C9B2C); //eyebrows
    pushMatrix();
    translate(cx-8, cy-22);
    rotate(PI/8);
    translate(-(cx-17), -(cy-17));
    rect(cx-17, cy-17, 15, 3);
    popMatrix();

    pushMatrix();
    translate(cx+10, cy-18);
    rotate(-PI/8);
    translate(-(cx+17), -(cy-10));
    rect(cx+17, cy-10, 10, 2);
    popMatrix();
    popMatrix();
  }
  void drawSnowPea() {
    //noStroke();
    pushMatrix();
    smooth();
    translate(cx, cy);
    scale(scal);
    translate(-cx, -cy);

    fill(#6CD6CC);
    polygon(cx-35, cy-10, 10, 5);
    polygon(cx-40, cy, 10, 5);
    polygon(cx-35, cy+10, 10, 5);

    fill(#1C9B2C);
    //bottom leaves

    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();

    pushMatrix();
    translate(cx+2, cy+106);
    rotate(TWO_PI/6);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx, cy+110);
    rotate(TWO_PI/2);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    pushMatrix();
    translate(cx-4, cy+106);
    rotate(4*PI/3);
    translate(-cx, -(cy+102));
    beginShape();
    vertex(cx, cy+102);
    quadraticVertex(cx+20, cy+80, cx+30, cy+90);
    quadraticVertex(cx+31, cy+100, cx, cy+110);
    vertex(cx, cy+102);
    endShape();
    popMatrix();

    fill(#1C9B2C);
    ellipse(cx, cy+50, 10, 120); //stem

    fill(#6CD6CC);
    ellipse(cx, cy+23, 20, 10); //stem attachment


    fill(#6CD6CC);
    ellipse(cx, cy, 70, 45); //head 
    ellipse(cx+40, cy, 30, 60); //beak
    fill(#09433E);
    ellipse(cx+42, cy, 20, 40); //inner mouth
    ellipse(cx, cy-5, 10, 15); // outer eyes
    ellipse(cx+15, cy-10, 7, 12); //outer eyes
    fill(255);
    ellipse(cx-1, cy-6, 4, 6); //inner eyes
    ellipse(cx+14, cy-11, 3, 5); //inner eyes 

    popMatrix();
  }

  void polygon(float x, float y, float r, int point) {
    float theta = TWO_PI / point;
    beginShape();
    for (float i = 0; i < TWO_PI; i += theta) {
      float sx = x + cos(i) * r;
      float sy = y + sin(i) * r;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }


  void update() {
    cx=mouseX;
    cy=mouseY;
  }
}

class pea {
  float posX, posY;
  pea(float x, float y) {
    posX=x;
    posY=y;
  }
  void drawPea() {
    fill(#C1EA74);
    ellipse(posX+20, posY, 20, 20);
  }
  void drawSnow() {
    fill(#6CD6CC);
    ellipse(posX+20, posY, 20, 20);
  }

  void update() {
    posX++;
  }
}

class button {
  float posX, posY;
  String s;
  sunFlower SF;
  sun Sun;
  plant PS,R,SP;
  button(float x, float y) {
    posX=x;
    posY=y;
    SF=new sunFlower(posX+35, posY+55, 0.2);
    Sun=new sun(posX+60, posY+70, 0.5);
    PS=new plant(posX+35,posY+20,0.3);
    R=new plant(posX+35,posY+20,0.3);
    SP=new plant(posX+35,posY+20,0.3);
    
  }
  void drawSFButton() {
    s="<BLOOM & DOOM SEED CO.>";
    fill(255, 250, 245);
    rect(posX, posY, 70, 80);
    fill(199, 255, 191);
    rect(posX, posY+10, 70, 50);
    fill(0, 0, 0);  
    textAlign(CENTER);
    textSize(4);
    text(s, posX, posY+2, 70, 10);
    textSize(16);
    text("50", posX, posY+60, 70, 20);
    SF.drawSF();
    Sun.drawSun();
  }
  
  void drawPSButton(){
     s="<BLOOM & DOOM SEED CO.>";
    fill(255, 250, 245);
    rect(posX, posY, 70, 80);
    fill(199, 255, 191);
    rect(posX, posY+10, 70, 50);
    fill(0, 0, 0);  
    textAlign(CENTER);
    textSize(4);
    text(s, posX, posY+2, 70, 10);
    textSize(16);
    text("100", posX, posY+60, 70, 20);
    PS.drawPeaShooter();
    Sun.drawSun();
  }
  
    
  void drawRButton(){
     s="<BLOOM & DOOM SEED CO.>";
    fill(255, 250, 245);
    rect(posX, posY, 70, 80);
    fill(199, 255, 191);
    rect(posX, posY+10, 70, 50);
    fill(0, 0, 0);  
    textAlign(CENTER);
    textSize(4);
    text(s, posX, posY+2, 70, 10);
    textSize(16);
    text("200", posX, posY+60, 70, 20);
    R.drawRepeater();
    Sun.drawSun();
  }
  
    
  void drawSPButton(){
     s="<BLOOM & DOOM SEED CO.>";
    fill(255, 250, 245);
    rect(posX, posY, 70, 80);
    fill(199, 255, 191);
    rect(posX, posY+10, 70, 50);
    fill(0, 0, 0);  
    textAlign(CENTER);
    textSize(4);
    text(s, posX, posY+2, 70, 10);
    textSize(16);
    text("175", posX, posY+60, 70, 20);
    SP.drawSnowPea();
    Sun.drawSun();
  }
}


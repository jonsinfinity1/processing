int width = 800; //<>// //<>//
int height = 400;

// edge length of square to use for calculations
int squareSideWidth = 50;

PVector redBox, blueBoxCurrent;

int originX, originY;

float lengthOfString = 250;
float angle = 0;

void setup() {
  size(800, 400);
  
  redBox = new PVector((width / 2) - (squareSideWidth / 2), 0);
  
  originX = 0;
  originY = (height / 2) - (squareSideWidth / 2);
  
  blueBoxCurrent = new PVector(originX, originY);
}

boolean movingRight = true;
boolean stepping = true;

void draw() {

  background(255);
  
  //"left-right" button
  fill(0, 0, 255);
  rect(width - 200, 10, 60, 20);
  fill(255, 255, 255);
  text("left-right", width - 196, 25);
  
  //"pendulum" button
  fill(0, 0, 255);
  rect(width - 100, 10, 60, 20);
  fill(255, 255, 255);
  text("pendulum", width - 99, 25);

  stroke(0);
  line(redBox.x + (squareSideWidth / 2), redBox.y + (squareSideWidth / 2), blueBoxCurrent.x + (squareSideWidth / 2), blueBoxCurrent.y + (squareSideWidth / 2));

  fill(255, 0, 0);
  rect(redBox.x, redBox.y, squareSideWidth, squareSideWidth);
  
  if (stepping) {
    step();
  } else {
    swing();
  }
}

void step() {
  
  fill(0, 0, 255);
  rect(movingRight ? blueBoxCurrent.x++ : blueBoxCurrent.x--, blueBoxCurrent.y, squareSideWidth, squareSideWidth);
  
  if(blueBoxCurrent.x == width-squareSideWidth) {
    movingRight = false;
  } else if (blueBoxCurrent.x == 0) {
    movingRight = true;
  }
}

void swing() {
  
    PVector blueBox = new PVector(blueBoxCurrent.x, blueBoxCurrent.y);
  
    fill(0, 0, 255);
    rect(blueBox.x, blueBox.y, squareSideWidth, squareSideWidth);

    fill(0, 0, 0);
    text("X :" + blueBox.x , blueBox.x, blueBox.y + squareSideWidth + 20); 
    text("Y :" + blueBox.y , blueBox.x, blueBox.y + squareSideWidth + 35); 

    stepPendulum();
}

void stepPendulum() {

  blueBoxCurrent.x = redBox.x + lengthOfString * sin(angle);
  blueBoxCurrent.y = redBox.y + lengthOfString * cos(angle);

  if (!movingRight && (angle < -PI/4)) {
    movingRight = true;
  } else if (movingRight && (angle > PI/4)) {
    movingRight = false;
  }

  // step instructions for current step
  //if (Direction.FORWARD.equals(direction)) {
  if (movingRight) {
    angle += 0.01;
  } else {
    angle -= 0.01;
  }

}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      blueBoxCurrent.y = adjustForVerticalBoundries((int)blueBoxCurrent.y - squareSideWidth);
    } else if (keyCode == DOWN) {
      blueBoxCurrent.y = adjustForVerticalBoundries((int)blueBoxCurrent.y + squareSideWidth);
    } 
  } else {
    movingRight = movingRight ? false : true;
  }
}

boolean looping = true;

void mousePressed() {
  //evaluate "left-right" button clicked
  if (mouseX > (width - 200) && mouseX < ((width - 200) + 60)
    && mouseY > 10 && mouseY < (10 + 60)) {
      println("clicked left-right");
      
      movingRight = true;
      redBox = new PVector((width / 2) - (squareSideWidth / 2), 0);
      blueBoxCurrent = new PVector(0, height / 2);

      stepping = true;
  }
  
  //evaluate "pendulum" button clicked
  if (mouseX > (width - 100) && mouseX < ((width - 100) + 60)
    && mouseY > 10 && mouseY < (10 + 60)) {
      println("clicked pendulum");
      
      movingRight = true;
      redBox = new PVector((width / 2) - (squareSideWidth / 2), 0);
      blueBoxCurrent = new PVector((width / 2) - (squareSideWidth / 2), lengthOfString);
      
      stepping = false;
  }
  
  boolean boxClicked = false;
  for(int i = 0; i < squareSideWidth; i++) {
    if(mouseX == blueBoxCurrent.x + i) {
      for(int j = 0; j < squareSideWidth; j++) {
        if(mouseY == blueBoxCurrent.y + j) {
          if (looping) {
            noLoop();
            looping = false;
          } else {
            loop();
            looping = true;
          }
          boxClicked = true;
        }
      }
    } 
  }
  
  if(!boxClicked) {
    blueBoxCurrent.y = adjustForVerticalBoundries(mouseY-(squareSideWidth/2));
  }
}

private int adjustForVerticalBoundries(int y) {
  y = y < 0 ? 0 : y;
  y = y > 400-squareSideWidth ? 400-squareSideWidth : y;
  return y;
}

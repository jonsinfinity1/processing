int width = 800; //<>//
int height = 400;

// edge length of square to use for calculations
int squareSideWidth = 50;

PVector redBox, blueBox;

void setup() {
  size(800, 400);
  
  redBox = new PVector((width / 2) - (squareSideWidth / 2), 0);
  
  blueBox = new PVector(0, (height / 2) - (squareSideWidth / 2));
}

boolean movingRight = true;

void draw() {

  background(255);

  stroke(0);
  line(redBox.x + (squareSideWidth / 2), redBox.y + (squareSideWidth / 2), blueBox.x + (squareSideWidth / 2), blueBox.y + (squareSideWidth / 2));

  fill(255, 0, 0);
  rect(redBox.x, redBox.y, squareSideWidth, squareSideWidth);

  fill(0, 0, 255);
  rect(movingRight ? blueBox.x++ : blueBox.x--, blueBox.y, squareSideWidth, squareSideWidth);
  
  step();
}

void step() {
  if(blueBox.x == width-squareSideWidth) {
    movingRight = false;
  } else if (blueBox.x == 0) {
    movingRight = true;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      blueBox.y = adjustForVerticalBoundries((int)blueBox.y - squareSideWidth);
    } else if (keyCode == DOWN) {
      blueBox.y = adjustForVerticalBoundries((int)blueBox.y + squareSideWidth);
    } 
  } else {
    movingRight = movingRight ? false : true;
  }
}

boolean looping = true;

void mousePressed() {
  System.out.println(mouseX + " " + mouseY);
  System.out.println(blueBox.x + " " + blueBox.y); //<>//
  
  boolean boxClicked = false;
  for(int i = 0; i < squareSideWidth; i++) {
    if(mouseX == blueBox.x + i) {
      for(int j = 0; j < squareSideWidth; j++) {
        if(mouseY == blueBox.y + j) {
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
    blueBox.y = adjustForVerticalBoundries(mouseY-(squareSideWidth/2));
  }
}

private int adjustForVerticalBoundries(int y) {
  y = y < 0 ? 0 : y;
  y = y > 400-squareSideWidth ? 400-squareSideWidth : y;
  return y;
}

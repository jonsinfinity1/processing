void setup() {
  //size of canvas 
 // https://processing.org/reference/size_.html (width, height) 
 size(800, 800);
 
 
 
 
}

void draw() {
  //Color in the canvas background
  //https://processing.org/reference/background_.html
    background(255, 255, 255);
    
    fill(255, 0, 0);
    stroke(0);
    rect(380, 0, 40, 40);
    
    fill(0, 0, 255);
    stroke(0);
    rect(0, 380, 40, 40);
    
    line(400, 20, 20, 400);
}

import controlP5.*;
ControlP5 cp5;

boolean setupStage = true;
ArrayList<PVector> vertices = new ArrayList<PVector>();
PVector cursor;

Button startStopButton;
Textlabel iterationsLabel;
int iterations = 0;

int factorSlider = 50;
float factor = 0.5f;

void setup(){
  size(600,400);
  cp5 = new ControlP5(this);
  
  background(255);
  
  startStopButton = cp5.addButton("startStopButtonHandler")
      .setPosition(5,5)
      .setSize(100, 40)
      .setCaptionLabel("Start");
      
  iterationsLabel = cp5.addLabel("iterationsLabel")
      .setPosition(115, 10)
      .setText("Iterations")
      .setFont(createFont("default",12))
      .setColor(0);
      
  cp5.addSlider("factorSlider")
      .setPosition(180, 30)
      .setRange(0, 100)
      .setSize(60, 10)
      .setCaptionLabel("Factor value");
}

void draw(){
  fill(200);
  rect(0,0, 600, 50);
  
  if(setupStage){
    if(isMouseClicked()){
      vertices.add(new PVector(mouseX, mouseY));
      fill(123);
      circle(mouseX, mouseY, 10);
    }
  }
  else{
    iterate(1000);
  }
}

void iterate(int times){
  for (int i = 0; i < times; i++){
    int index = floor(random(vertices.size()));
    setNewCursorPosition(vertices.get(index));
    fill(0);
    circle(cursor.x, cursor.y, 1);
  }
  increaseIterations(times);
}

void setNewCursorPosition(PVector target){
   float dx = target.x - cursor.x;
   float dy = target.y - cursor.y;
   
   cursor.x += dx * factor;
   cursor.y += dy * factor;
}












void increaseIterations(int amount){
  iterations += amount;
  iterationsLabel.setText("Iterations:\n" + iterations);
}

void startStopButtonHandler(){
  if(setupStage){
    setupStage = false;
    startStopButton.setCaptionLabel("Stop");
    cursor = new PVector(vertices.get(0).x, vertices.get(0).y);
    factor = factorSlider / 100f;
  }
  else{
    setupStage = true;
    startStopButton.setCaptionLabel("Start");
    vertices.clear();
    increaseIterations(-iterations);
    background(255);
  }
}


boolean prevMouseState = false;
boolean isMouseClicked(){
  boolean clicked = prevMouseState && !mousePressed;
  prevMouseState = mousePressed;
  return clicked && mouseY > 50;
}

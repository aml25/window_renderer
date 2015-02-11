import java.awt.MouseInfo;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.Dimension;

Dimension screenSize;

ArrayList<Draggable> vertices = new ArrayList<Draggable>();

PGraphics render;
Rectangle screen;
BufferedImage screenCapture;
PImage screenTexture;
Robot screenCap;

boolean calibrate;

PImage cursor;

int gridCellCount = 2;
int oneDimension = gridCellCount + 1;

int scale = 2;

void setup(){
  screenSize = Toolkit.getDefaultToolkit().getScreenSize();
  println(screenSize);
  size( (int) screenSize.getWidth()/scale,  (int) screenSize.getHeight()/scale, P3D);
  
  
  cursor = loadImage("cursor.png");
  
  render = createGraphics(width, height, P3D);
  render.fill(255,255,0);
  render.stroke(255);
  
  textureMode(NORMAL);
  
  println(width + ", " + height);
  float xSpace = width/gridCellCount;
  float ySpace = height/gridCellCount;
  for(int y=0;y<=gridCellCount;y++){
    float coordY = y * ySpace;
    for(int x=0;x<=gridCellCount;x++){
      float coordX = x * xSpace;
      vertices.add(new Draggable(coordX, coordY));
      println("coord at: " + coordX + ", " + coordY);
    }
  }
  noStroke();
  
  try{
    screenCap = new Robot();
    screen = new Rectangle(screenSize);
  }
  catch(Exception e){
    e.printStackTrace();
  }
}

void drawVertex(Draggable currVertex){
  float u;
  float v;
  if(currVertex.originalX == 0){ //if on the left of the screen
    u = 0;  
  }
  else if(currVertex.originalX == width){ //if on the right of the screen
    u = 1;
  }
  else{ //somewhere in the middle
    u = map(currVertex.originalX, 0, width, 0, 1);
  }
  
  if(currVertex.originalY == 0){ //if on the top of the screen
    v = 0;  
  }
  else if(currVertex.originalY == height){ //if on the bottom of the screen
    v = 1;  
  }
  else{ //somewhere in the middle
    v = map(currVertex.originalY, 0, height, 0, 1);
  }
  vertex(currVertex.x, currVertex.y, u, v);  
}

void captureScreen(){
  screenTexture = new PImage(screenCap.createScreenCapture(screen));
  //screenCapture = screenCap.createScreenCapture(screen);
}

void draw(){
  //println(frameRate);
  background(0);
  
  try{
    
    //thread("captureScreen");
    captureScreen();
    //if(screenCapture != null){
      //screenTexture = new PImage(screenCapture);
      //screenCapture = null;
      
      int x = MouseInfo.getPointerInfo().getLocation().x;
      int y = MouseInfo.getPointerInfo().getLocation().y;
      
      render.beginDraw();
      //render.background(0);
      render.image(screenTexture,0,0);
      
      render.image(cursor, x,y);
      render.endDraw();
      
      beginShape(TRIANGLES);
      texture(render);
      
      for(int i=0;i<vertices.size();i++){
        if(i % (oneDimension) == gridCellCount){ //find the last one in the row, not the first
          //println(i);
        }
        else{
          if(i < vertices.size() - oneDimension){
            //println("drawing vertex for index: " + i + "," + (i+3) + ", " + (i+4));
            drawVertex(vertices.get(i));
            drawVertex(vertices.get(i+oneDimension));
            drawVertex(vertices.get(i+(oneDimension + 1)));
            
            //println("drawing vertex for index: " + i + "," + (i+1) + ", " + (i+4));
            drawVertex(vertices.get(i));
            drawVertex(vertices.get(i+1));
            drawVertex(vertices.get(i+(oneDimension + 1)));
            //println("------------------------------------------------");
          }
        }
      }
      
      endShape(CLOSE);
      
      for(int i=0;i<vertices.size();i++){
        if(vertices.get(i) != null){
          vertices.get(i).drawDraggable();  
        }
      }
    }
  //}
  catch( Exception e){
    e.printStackTrace();
  }
}

void keyPressed(){
  if(key == 'c'){ //calibrate toggle
    calibrate = !calibrate;
  }  
}

void mousePressed(){
  for(int i=0;i<vertices.size();i++){
    if(vertices.get(i).hovered){
      vertices.get(i).dragging = true;
      println(i);
      break;  
    }
  }
}

void mouseMoved(){
  cursor(ARROW);
  
}

void mouseReleased(){
  for(int i=0;i<vertices.size();i++){
    if(vertices.get(i).hovered){
      vertices.get(i).dragging = false;
      break;
    }
  }
  
  noCursor();
}

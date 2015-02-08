import java.awt.MouseInfo;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.Dimension;

Dimension screenSize;
Draggable[] vertexPoints = new Draggable[9];
PGraphics render;
Rectangle screen;
BufferedImage screenCapture;
PImage screenTexture;
Robot screenCap;

void setup(){
  screenSize = Toolkit.getDefaultToolkit().getScreenSize();
  println(screenSize);
  size( (int) screenSize.getWidth(),  (int) screenSize.getHeight(), P2D);
  
  render = createGraphics(width, height, P2D);
  render.fill(255,255,0);
  render.stroke(255);
  
  textureMode(IMAGE);
  
  vertexPoints[0] = new Draggable(0,0);
  vertexPoints[1] = new Draggable(width*.5,0);
  vertexPoints[2] = new Draggable(width,0);
  
  vertexPoints[3] = new Draggable(width,height*.5);
  vertexPoints[4] = new Draggable(width*.5,height*.5);
  vertexPoints[5] = new Draggable(0,height*.5);
  
  vertexPoints[6] = new Draggable(width,height);
  vertexPoints[7] = new Draggable(width/2,height);
  vertexPoints[8] = new Draggable(0,height);
  
  noStroke();
  
  try{
    screenCap = new Robot();
    screen = new Rectangle(screenSize);
    println("got the screen");
  }
  catch(Exception e){
    e.printStackTrace();
  }
}

void draw(){
  background(0);
  
  try{
    
    screenCapture = screenCap.createScreenCapture(screen);
    
    screenTexture = new PImage(screenCapture);
    
    int x = MouseInfo.getPointerInfo().getLocation().x;
    int y = MouseInfo.getPointerInfo().getLocation().y;
    
    render.beginDraw();
    //render.background(0);
    render.image(screenTexture,0,0);
    
    render.ellipse(x,y,10,10);
    render.endDraw();
    
    //I know the U value is not correct.  but as long as I don't squish on the edges, it should be right
    beginShape();
    
    texture(render);
    vertex(vertexPoints[0].x, vertexPoints[0].y, 0, 0);
    vertex(vertexPoints[1].x, vertexPoints[1].y, vertexPoints[1].x, 0);
    vertex(vertexPoints[2].x, vertexPoints[2].y, width, 0);
    
    vertex(vertexPoints[3].x, vertexPoints[3].y, width, render.height*.5);
    vertex(vertexPoints[4].x, vertexPoints[4].y, vertexPoints[4].x, render.height*.5);
    vertex(vertexPoints[5].x, vertexPoints[5].y, 0, render.height*.5);
    
    vertex(vertexPoints[5].x, vertexPoints[5].y, 0, render.height*.5);
    vertex(vertexPoints[4].x, vertexPoints[4].y, vertexPoints[4].x, render.height*.5);
    vertex(vertexPoints[3].x, vertexPoints[3].y, width, render.height*.5);
    
    vertex(vertexPoints[6].x, vertexPoints[6].y, width, render.height);
    vertex(vertexPoints[7].x, vertexPoints[7].y, vertexPoints[7].x, render.height);
    vertex(vertexPoints[8].x, vertexPoints[8].y, 0, render.height);
    endShape();
    
    for(int i=0;i<vertexPoints.length;i++){
      if(vertexPoints[i] != null){
        vertexPoints[i].drawDraggable();  
      }
    }    
  }
  catch( Exception e){
    e.printStackTrace();
  }
}

void mousePressed(){
  for(int i=0;i<vertexPoints.length;i++){
    if(vertexPoints[i].hovered){
      vertexPoints[i].dragging = true;
      println(i);
      break;  
    }
  }
}

void mouseMoved(){
  cursor(ARROW);
  
}

void mouseReleased(){
  for(int i=0;i<vertexPoints.length;i++){
    if(vertexPoints[i].hovered){
      vertexPoints[i].dragging = false;
      break;
    }
  }
  noCursor();
}

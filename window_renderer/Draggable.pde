class Draggable{
  
  float x;
  float originalX;
  float y;
  float originalY;
  boolean dragging = false;
  boolean hovered = false;
  int radius = 25;
  
  Draggable(float myX, float myY){
    x = myX;
    originalX = x;
    y = myY;
    originalY = y;
  }
  
  void drawDraggable(){
    mouseInside();
    if(calibrate){
      ellipseMode(CENTER);
      stroke(60,100,255);
      if(hovered){
        fill(60,100,255);  
      }
      else{
        noFill();
        
      }
      ellipse(x, y, radius,radius);
    }
    else{
      noStroke();
      noFill();  
    }
    
    if(dragging){
      x = mouseX;
      y = mouseY;  
    }
  }
  
  void mouseInside(){
    if(mouseX < x + radius/2 && mouseX > x - radius/2 && mouseY > y - radius/2 && mouseY < y + radius/2){
      hovered = true;
    } 
    else{
      hovered = false; 
    }
  }
}

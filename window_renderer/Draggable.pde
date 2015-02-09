class Draggable{
  
  float x;
  float originalX;
  float y;
  float originalY;
  boolean dragging = false;
  boolean hovered = false;
  int radius = 50;
  
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
      if(hovered){
        fill(60,100,255);  
      }
      else{
        fill(255,0,255);
      }
      ellipse(x, y, radius,radius);
      fill(0);
      ellipse(x, y, 5, 5);
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

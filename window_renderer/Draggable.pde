class Draggable{
  
  float x;
  float y;
  boolean dragging = false;
  boolean hovered = false;
  int radius = 100;
  
  Draggable(float myX, float myY){
    x = myX;
    y = myY;
  }
  
  void drawDraggable(){
    mouseInside();
    if(hovered){
      ellipseMode(CENTER);
      fill(255,0,255);
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

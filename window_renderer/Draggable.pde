class Draggable{
  
  float x;
  float y;
  boolean dragging = false;
  boolean hovered = false;
  
  Draggable(float myX, float myY){
    x = myX;
    y = myY;
  }
  
  void drawDraggable(){
    mouseInside();
    if(hovered){
      fill(255,0,255);
      ellipse(x, y, 50,50);
    }
    
    if(dragging){
      x = mouseX;
      y = mouseY;  
    }
  }
  
  void mouseInside(){
    if(mouseX < x + 50 && mouseX > x - 50 && mouseY > y - 50 && mouseY < y + 50){
      hovered = true;
    } 
    else{
      hovered = false; 
    }
  }
}

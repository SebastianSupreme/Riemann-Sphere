

class Pixel{
  
  PVector position;
  PVector rgb;
  
  public Pixel(){
    
  }
  
  void setPosition(PVector position){
    
    this.position = position;
    
  }
  
  void setColor(PVector rgb){
   
    this.rgb = rgb;
    
  }
  
  void drawPixel(){
    
    if(rgb != null)
    stroke(rgb.x, rgb.y, rgb.z);
    
    if(position != null)
    point(position.x, position.y, position.z);
    
  }
  
  
}

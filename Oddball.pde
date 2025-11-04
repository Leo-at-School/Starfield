public class Oddball extends Particle{
  //Constants
  private double maxGrowTime = 5;
  private double maxRadius = Math.sqrt(width*width + height*height);
  
  //Set by constructor
  private double radius, x, y, startTime;
  private color oddballColor;
  
  Oddball(double initX, double initY, double initStartTime, color initOddballColor){
    super(initX, initY, 0, 0, initStartTime);
    x = super.getX();
    y = super.getY();
    startTime = super.getStartTime();
    
    
    oddballColor = initOddballColor;
  }
  
  //Increase the radius of the oddball
  private int grow(double time){
    if (time < startTime){
      return 0; //Dont draw
    }
    
    double oddballTime = (time - startTime); //The time the oddball has been drawing for
    
    //Draw but dont update
    if  (oddballTime >= maxGrowTime){
      return 2;
    }
    
    if (time - startTime < maxGrowTime){
      radius = maxRadius*((oddballTime*oddballTime)/(maxGrowTime));
    } else {
      radius = maxRadius;
    }
    
    return 1;
  }
  
  //Call the grow method and draw the oddball
  public boolean drawOddball(double time){
    int drawOddball = grow(time);
    
    if (drawOddball > 0){
      noStroke();
      fill(oddballColor);
      ellipse((float)x, (float)y, (float)radius, (float)radius);
      
      return drawOddball == 1;
    }
    
    return false;
  }
  
  public double getMaxGrowTime(){
    return maxGrowTime;
  }
}

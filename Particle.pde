public class Particle{
  //Constants
  private int scaleParticleSize = 30;
  private double maxSpeed = 3.5;
  private double maxSpeedTime = 20;
  
  //Set by constructor
  private double distance, radius, speed, angle, x, y, startTime;;
  private color particleColor;
  
  Particle(double initX, double initY, double initSpeed, double initAngle, double initStartTime){
    x = initX;
    y = initY;
    speed = initSpeed;
    angle = initAngle;
    startTime = initStartTime;
    
    maxSpeed = Math.random()*3 + 3;
    distance = Math.sqrt(x*x + y*y);
    radius = distance/scaleParticleSize;
    particleColor = color(255, 0, 0);
  }
  
  //Update a particle's position
  private boolean move(double time){
    if (time < startTime){
      return false;
    }
    double praticleTime = time - startTime;
    
    x += speed*Math.cos(angle);
    y += speed*Math.sin(angle);
    distance = Math.sqrt((x - width/2)*(x - width/2) + (y - height/2)*(y - height/2));
    radius = distance/scaleParticleSize;
    
    if (praticleTime < maxSpeedTime){
      speed = maxSpeed*radius*(praticleTime/maxSpeedTime);
    } else {
      speed = maxSpeed*radius;
    }
    
    boolean[] offscreenChecks = {
      x - radius > width && y + radius > 0,
      x - radius > width && y - radius < height,
      x + radius < 0 && y + radius > 0,
      x + radius < 0 && y - radius < height
    };
    
    for (int i = 0; i < offscreenChecks.length; i++){
      if (offscreenChecks[i]){
        x = width/2;
        y = height/2;
        radius = 0;
        angle = Math.random()*2*PI;
        return true;
      }
    }
    return true;
  }
  
  //Call the move method and draw the particle
  public void drawParticle(double time){
    //Check if the particle can draw
    if (this.move(time)){
      noStroke();
      fill(particleColor);
      ellipse((float)x, (float)y, (float)(radius), (float)(radius));
    }
  }
  
  public double getX(){
    return x;
  }
  
  public double getY(){
    return y;
  }
  
  public double getStartTime(){
    return startTime;
  }
}

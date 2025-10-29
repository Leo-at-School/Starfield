int starTrailIntensity = 100; //1 - 255
color backgroundColor = color(0, 0, 0, starTrailIntensity);
color initialBackgroundColor = color(0, 0, 0);
double time  = 0;
int frame = 0;

int particleAmount = 101;
double[] startDelayArray = new double[particleAmount];
Particle[] stars = new Particle[particleAmount];

int scaleParticleSize = 30;
double scaleSpeed = 2;
double maxSpeed = 10;
double maxSpeedTime = 20;
double maxStartDelay = 0;
boolean canDraw = false;

void setup(){
  size(800, 600);
  background(backgroundColor);
  
  //Fill an array with the start times of each particle
  for (int i = 0; i < stars.length; i++){
    startDelayArray[i] = Math.random()*8;
    maxStartDelay = Math.max(maxStartDelay, startDelayArray[i]);
  }
  
  //Fill an array of all the particles
  double initX, initY, initSpeed, initAngle, initStartTime;
  for (int i = 0; i < stars.length - 1; i++){
    initX = width/2;
    initY = height/2;
    initSpeed = Math.random()*2 + 1;
    initAngle = Math.random()*2*PI;
    initStartTime = startDelayArray[i];
    
    stars[i] = new Particle(initX, initY, initSpeed, initAngle, initStartTime);
  }
  
  stars[stars.length - 1] = new Oddball(initX, initY, initSpeed, initAngle, initStartTime);
}

void draw(){
  fill(backgroundColor);
  rect(0, 0, width, height);
  
  for (int i = 0; i < stars.length; i++){
    canDraw = stars[i].move(time);
    stars[i].drawParticle(canDraw);
  }
  
  frame = (frame + 1)%60;
  
  if (time < maxStartDelay){
    time += 1.0/60;
  }
}

class Particle{
  double x, y, distance, radius, speed, angle, startTime;
  color particleColor;
  Particle(double initX, double initY, double initSpeed, double initAngle, double initStartTime){
    x = initX;
    y = initY;
    speed = initSpeed;
    angle = initAngle;
    startTime = initStartTime;
    
    distance = Math.sqrt(x*x + y*y);
    radius = distance/scaleParticleSize;
    particleColor = color(255, 0, 0);
  }
  
  boolean move(double time){
    if (time < startTime){
      return false;
    }
    
    x += speed*Math.cos(angle);
    y += speed*Math.sin(angle);
    distance = Math.sqrt((x - width/2)*(x - width/2) + (y - height/2)*(y - height/2));
    radius = distance/scaleParticleSize;
    
    if (time < maxSpeedTime){
      speed = maxSpeed*radius*(time/maxSpeedTime);
    } else {
      speed = maxSpeed*radius;
    }
    
    speed /= scaleSpeed;
    
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
  
  void drawParticle(boolean canDraw){
    if (canDraw){
      noStroke();
      fill(particleColor);
      ellipse((float)x, (float)y, (float)(radius), (float)(radius));
    }
  }
}

class Oddball extends Particle{
  Oddball(double initX, double initY, double initSpeed, double initAngle, double initStartTime){
    super(initX, initY, initSpeed, initAngle, initStartTime);
  }
  
  void move(){
    
  }
  
  void drawOddball(){
  
  }
}

color initialBackgroundColor = color(0, 0, 0);
int starTrailIntensity = 100; //1 - 255
color backgroundColor = color(0, 0, 0, starTrailIntensity);

int scaleParticleSize = 30;
double scaleSpeed = 1.1;
int particleAmount = 200;
Particle[] stars = new Particle[particleAmount];

void setup(){
  size(800, 600);
  background(backgroundColor);
  
  double initX, initY, initSpeed, initAngle;
  
  for (int i = 0; i < stars.length; i++){
    initX = width/2;
    initY = height/2;
    initSpeed = Math.random()*5;
    initAngle = Math.random()*2*PI;
    
    stars[i] = new Particle(initX, initY, initSpeed, initAngle);
  }
}

void draw(){
  fill(backgroundColor);
  rect(0, 0, width, height);
  
  for (int i = 0; i < stars.length; i++){
    stars[i].move();
    stars[i].drawParticle();
  }
}

class Particle{
  double x, y, distance, radius, startingSpeed, speed, angle;
  color particleColor;
  Particle(double initX, double initY, double initSpeed, double initAngle){
    x = initX;
    y = initY;
    startingSpeed = initSpeed;
    speed = initSpeed;
    angle = initAngle;
    
    distance = Math.sqrt(x*x + y*y);
    radius = distance/scaleParticleSize;
    particleColor = color(255, 255, 255);
  }
  
  void move(){
    x += speed*Math.cos(angle);
    y += speed*Math.sin(angle);
    
    distance = Math.sqrt((x - width/2)*(x - width/2) + (y - height/2)*(y - height/2));
    radius = distance/scaleParticleSize;
    speed = radius*scaleSpeed;
    
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
        speed = startingSpeed;
        angle = Math.random()*2*PI;
        break;
      }
    }
  }
  void drawParticle(){
    noStroke();
    fill(particleColor);
    ellipse((float)x, (float)y, (float)(radius), (float)(radius));
  }
}

class Oddball extends Particle{
  Oddball(double initX, double initY, double initSpeed, double initAngle){
    super(initX, initY, initSpeed, initAngle);
  }
}

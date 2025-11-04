int particleAmount = 100;
int oddballAmount = 2;
int starTrailIntensity = 100; //1 - 255
int frame = 0;

double time  = 0;
double maxStartDelay;

color backgroundColor = color(0, 0, 0, starTrailIntensity);
color initialBackgroundColor = color(0, 0, 0);

boolean oddballDrawing;

double[] startDelayArray = new double[particleAmount + oddballAmount];
Particle[] stars = new Particle[startDelayArray.length];


void setup(){
  size(800, 600);
  background(backgroundColor);
  
  //Fill startDelayArray with the start times of each particle
  for (int i = oddballAmount; i < stars.length; i++){
    startDelayArray[i] = Math.random()*8;
    maxStartDelay = Math.max(maxStartDelay, startDelayArray[i]);
  }
  
  //Fill startDelayArray with the start times of each oddball
  for (int i = 0; i < oddballAmount; i++){
    if (i == 0){
      startDelayArray[i] = Math.random()*5 + 2 + maxStartDelay;
    } else if (i > 0 && i < oddballAmount){
      startDelayArray[i] = startDelayArray[i - 1] + 5;
    }
    maxStartDelay = Math.max(maxStartDelay, startDelayArray[i]);
  }
  
  //Fill an array of all the particles
  double initX = width/2;
  double initY = height/2;
  double initSpeed, initAngle, initStartTime, initOddballStartTime;
  color initOddballColor;
  
  for (int i = 0; i < stars.length; i++){
    if (i < oddballAmount){
      if (i%2 == 1){
        initOddballColor = color(0, 0, 0);
      } else {
        initOddballColor = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
      }
      
      initOddballStartTime = startDelayArray[i];
      
      stars[i] = new Oddball(initX, initY, initOddballStartTime, initOddballColor);
    } else {
      initSpeed = Math.random() + 1.5;
      initAngle = Math.random()*2*PI;
      initStartTime = startDelayArray[i];
      
      stars[i] = new Particle(initX, initY, initSpeed, initAngle, initStartTime);
    }
  }
  
  if (oddballAmount > 0){
    maxStartDelay += ((Oddball)stars[0]).getMaxGrowTime();
  }
}

void draw(){
  fill(backgroundColor);
  rect(0, 0, width, height);
  
  for (int i = 0; i < stars.length; i++){
    if(i < oddballAmount){
      oddballDrawing = ((Oddball)stars[i]).drawOddball(time);
    } else {
      stars[i].drawParticle(time);
    }  
  }
  
  frame = (frame + 1)%60;
  
  if (time < maxStartDelay){
    time += 1.0/60;
  } else {
    time = 0;
  }
}

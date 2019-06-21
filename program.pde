boolean playing = false;
int frame = 0;
int numFrames = 61;
int fps = 20;
// Format: [lat/long-upperLeftCorner, lat/long-lowerRightCorner]
float[] latlongcorners = {-30, -25, 40, 0};
int[] boxCorners = {80, 313, 720, 530};

boolean manual = false;

int[] backwardXY = {330, 20};
int[] playXY = {400, 20};
int[] forwardXY = {470, 20};

int[] scrollbarData = {60};
boolean[] scrollbarScroll = {false, false};

int hmouseX = -1;
int hmouseY = -1;
boolean record_hmouse = true;

float fixDec(float n) {
  return round(n * 1000.0) / 1000.0;
}

void mouseControl() {
  if(mousePressed) {
    if(record_hmouse == true) {
      hmouseX = mouseX;
      hmouseY = mouseY;
      record_hmouse = false;
    }
  }
  else {
    hmouseX = -1;
    hmouseY = -1;
    record_hmouse = true;
  }
}
boolean mouseBetween(int x1, int y1, int x2, int y2) {
    if(mouseX>x1 && mouseX<x2 && mouseY>y1 && mouseY<y2) {
        return true;
    }
    else {
        return false;
    }
}
boolean hmouseBetween(int x1, int y1, int x2, int y2) {
    if(hmouseX>x1 && hmouseX<x2 && hmouseY>y1 && hmouseY<y2) {
        return true;
    }
    else {
        return false;
    }
}
void backward(int x, int y) {
  noStroke();
  fill(255);
  if(mouseBetween(x, y-10, x+15+13, y+10)) {
    fill(100);
  }
  triangle(x, y, x+15, y-10, x+15, y+10);
  triangle(x+13, y, x+15+13, y-10, x+15+13, y+10);
}
void play(int x, int y) {
  noStroke();
  fill(255);
  if(mouseBetween(x-8, y-10, x+8, y+10)) {
    fill(100);
  }
  if(playing == true) {
    rect(x-7.5, y-10, 5, 20);
    rect(x+7.5-5, y-10, 5, 20);
  }
  else {
    triangle(x-7.5, y-10, x+7.5, y, x-7.5, y+10);
  }
}
void forward(int x, int y) {
  noStroke();
  fill(255);
  if(mouseBetween(x-15-13, y-10, x, y+10)) {
    fill(100);
  }
  triangle(x, y, x-15, y-10, x-15, y+10);
  triangle(x-13, y, x-15-13, y-10, x-15-13, y+10);
}

void scrollbar(int x, int y, int w, int input, int min, int max) {
  fill(100);
  rect(x, y, w, 6, 3);
  fill(255);
  if(dist(mouseX, mouseY, x+scrollbarData[input]*w/max, y+3) < 6) {
    fill(190);
  }
  if(mousePressed) {
    if(dist(mouseX, mouseY, x+scrollbarData[input]*w/max, y+3) < 6 && dist(hmouseX, hmouseY, x+scrollbarData[input]*w/max, y+3) < 6) {
      scrollbarScroll[input] = true;
    }
  }
  else {
    scrollbarScroll[input] = false;
  }
  if(scrollbarScroll[input] == true) {
    fill(190);
    if(mouseX <= x) {
      scrollbarData[input] = min;
    }
    else if(mouseX >= x+w) {
      scrollbarData[input] = max;
    }
    else {
      scrollbarData[input] = (mouseX-x)*max/w;
    }
  }
  if(scrollbarData[input] < min) {
    scrollbarData[input] = min;
  }
  ellipse(x+scrollbarData[input]*w/max, y+3, 12, 12);
}

void scrollbar1(int x, int y, int w, int input, int min, int max) {
  fill(100);
  rect(x, y, w, 6, 3);
  fill(255);
  if(dist(mouseX, mouseY, x+frame*w/max, y+3) < 6) {
    fill(190);
  }
  if(mousePressed) {
    if(dist(mouseX, mouseY, x+frame*w/max, y+3) < 6 && dist(hmouseX, hmouseY, x+frame*w/max, y+3) < 6) {
      scrollbarScroll[input] = true;
    }
  }
  else {
    scrollbarScroll[input] = false;
  }
  if(scrollbarScroll[input] == true) {
    fill(190);
    if(mouseX <= x) {
      frame = min;
    }
    else if(mouseX >= x+w) {
      frame = max;
    }
    else {
      frame = (mouseX-x)*max/w;
    }
  }
  if(frame < min) {
    frame = min;
  }
  ellipse(x+frame*w/max, y+3, 12, 12);
}

void manual_button(int x, int y) {
  fill(255);
  noStroke();
  if(mouseBetween(x, y, x+70, y+20)) {
    fill(200);
  }
  rect(x, y, 70, 20, 6);
  fill(50);
  textSize(15);
  if(mouseBetween(x, y, x+70, y+20)) {
    fill(120);
  }
  text("Manual", x+10, y+15);
}

void mouseClicked() {
  if(mouseBetween(forwardXY[0]-15-13, forwardXY[1]-10, forwardXY[0], forwardXY[1]+10) && hmouseBetween(forwardXY[0]-15-13, forwardXY[1]-10, forwardXY[0], forwardXY[1]+10)) {
    frame ++;
  }
  if(mouseBetween(backwardXY[0], backwardXY[1]-10, backwardXY[0]+15+13, backwardXY[1]+10) && mouseBetween(backwardXY[0], backwardXY[1]-10, backwardXY[0]+15+13, backwardXY[1]+10)) {
    if(frame == 0) {
      frame = numFrames-1;
    }
    else {
      frame --;
    }
  }
  if(mouseBetween(playXY[0]-8, playXY[1]-10, playXY[0]+8, playXY[1]+10) && hmouseBetween(playXY[0]-8, playXY[1]-10, playXY[0]+8, playXY[1]+10)) {
    playing = !playing;
  }
  if(mouseBetween(26, 9, 26+70, 9+20) && hmouseBetween(26, 9, 26+70, 9+20)) {
    manual = !manual;
  }
}

void keyPressed() {
  if(keyCode == 32) {
    playing = !playing;
  }
  if(keyCode == 37) {
    if(frame == 0) {
      frame = numFrames-1;
    }
    else {
      frame --;
    }
  }
  if(keyCode == 39) {
    frame ++;
  }
}

PImage[] img = {};
PImage backImg;

void setup() {
  size(800, 800);
  frameRate(60);
  backImg = loadImage("weather_images/aew_vort.700.hpa.2000.000000.png");
  for(int i = 0; i < numFrames; i++) {
    if(i < 10) {
      img = append(img, loadImage("weather_images/aew_vort.700.hpa.2000.00000"+str(i+1)+".png"));
    }
    else {
      img = append(img, loadImage("weather_images/aew_vort.700.hpa.2000.0000"+str(i+1)+".png"));
    }
  }
}

void draw() {
  mouseControl();
  if(playing == true && frameCount % int(60/fps) == 0) {
    frame ++;
  }
  fps = int(scrollbarData[0]);
  frame = int(frame % numFrames);
  background(255);
  textSize(15);
  text("LOADING...", (width-textWidth("LOADING..."))/2, height/2+30);
  image(backImg, 0, 40, width, height-40);
  image(img[frame], 0, 40, width, height-40);
  fill(0);
  strokeWeight(1);
  stroke(180);
  rect(-1, -1, width+1, 40);
  backward(backwardXY[0], backwardXY[1]);
  forward(forwardXY[0], forwardXY[1]);
  play(playXY[0], playXY[1]);
  scrollbar(180, 17, 100, 0, 1, 60);
  scrollbar1(585, 17, 180, 1, 0, numFrames-1);
  fill(255)
  textSize(12);
  text("FPS: "+str(int(fps)), 120, 25);
  text("Frame: "+str(int(frame)), 510, 25);
  manual_button(26, 9);
  if(manual == true) {
    fill(0);
    stroke(0);
    strokeWeight(1);
    textSize(10);
    line(398, 35, 398, 67);
    text("Start/stop\nanimation\n(SPACEBAR)", 380, 80);
    line(344, 37, 328, 67);
    text("Prev frame\n(LEFT)", 310, 80);
    line(450, 35, 486, 67);
    text("Next frame\n(RIGHT)", 460, 80);
    line(660, 33, 660, 67);
    text("Scroll frame", 633, 80);
    line(228, 32, 228, 67);
    text("Scroll framerate", 188, 80);
  }
  if(mouseBetween(boxCorners[0], boxCorners[1], boxCorners[2], boxCorners[3])) {
    fill(220, 220, 220, 200);
    stroke(80, 80, 80, 200);
    strokeWeight(2);
    textSize(11);
    rect(mouseX-5-textWidth(str(fixDec((latlongcorners[2]-latlongcorners[0])*(mouseX-boxCorners[0])/(boxCorners[2]-boxCorners[0])+latlongcorners[0]))+", "+str(fixDec((latlongcorners[3]-latlongcorners[1])*(mouseY-boxCorners[1])/(boxCorners[3]-boxCorners[1])+latlongcorners[1])))/2, mouseY-15-15, textWidth(str(fixDec((latlongcorners[2]-latlongcorners[0])*(mouseX-boxCorners[0])/(boxCorners[2]-boxCorners[0])+latlongcorners[0]))+", "+str(fixDec((latlongcorners[3]-latlongcorners[1])*(mouseY-boxCorners[1])/(boxCorners[3]-boxCorners[1])+latlongcorners[1])))+10, 21, 5)
    fill(0, 0, 0, 220);
    text(str(fixDec((latlongcorners[2]-latlongcorners[0])*(mouseX-boxCorners[0])/(boxCorners[2]-boxCorners[0])+latlongcorners[0]))+", "+str(fixDec((latlongcorners[3]-latlongcorners[1])*(mouseY-boxCorners[1])/(boxCorners[3]-boxCorners[1])+latlongcorners[1])), mouseX-textWidth(str(fixDec((latlongcorners[2]-latlongcorners[0])*(mouseX-boxCorners[0])/(boxCorners[2]-boxCorners[0])+latlongcorners[0]))+", "+str(fixDec((latlongcorners[3]-latlongcorners[1])*(mouseY-boxCorners[1])/(boxCorners[3]-boxCorners[1])+latlongcorners[1])))/2, mouseY-15);
  }
}


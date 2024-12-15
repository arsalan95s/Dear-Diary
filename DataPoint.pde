class DataPoint {
  // Variables
  PVector position;
  PVector velocity;
  float radius;
  color pointColor;
  int minutes;
  int lectureDay;
  boolean isSelected;
  
  DataPoint(float x, float y, int mins, int day) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    radius = 20;
    minutes = mins;
    lectureDay = day;
    pointColor = minutes < 0 ? color(0, 255, 0) : color(255, 0, 0);
    isSelected = false;
  }
  
  void update() {
    position.add(velocity);
    velocity.mult(0.95); //Damping
  }
  
  void display() {
    fill(pointColor);
    ellipse(position.x, position.y, radius * 2, radius * 2);
    fill(0);
    textAlign(CENTER, CENTER);
    text(minutes, position.x, position.y);
    
    if (isSelected) {
      noFill();
      stroke(0, 0, 255);
      ellipse(position.x, position.y, radius * 2.5, radius * 2.5);
      fill(0);
      text("Lecture " + lectureDay, position.x, position.y - radius - 10);
    }
  }
  
  void attract(float mx, float my) {
    PVector mouse = new PVector(mx, my);
    PVector dir = PVector.sub(mouse, position);
    float d = dir.mag();
    if (d < 100 && d > 0) {
      dir.normalize();
      float force = (100 - d) / 100;
      dir.mult(force * 0.5);
      velocity.add(dir);
    }
  }
  
  boolean isOver(float mx, float my) {
    float d = dist(mx, my, position.x, position.y);
    return d < radius;
  }
}

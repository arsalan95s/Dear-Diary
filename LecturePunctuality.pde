DataVisualizer visualizer;

void setup() {
  size(800, 600);
  visualizer = new DataVisualizer("Lecture_data.csv");
}

void draw() {
  background(240);
  visualizer.update();
  visualizer.display();
}

void mouseMoved() {
  visualizer.interact(mouseX, mouseY);
}

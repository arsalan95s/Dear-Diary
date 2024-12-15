class DataVisualizer {
  ArrayList<DataPoint> dataPoints;
  int maxValue, minValue;
  float yAxisCenter;
  
  DataVisualizer(String filename) {
    dataPoints = new ArrayList<DataPoint>();
    yAxisCenter = height - 100; // 
    loadData(filename);
  }
  
  void loadData(String filename) {
    Table data = loadTable(filename, "header");
    maxValue = Integer.MIN_VALUE;
    minValue = Integer.MAX_VALUE;
    
    for (TableRow row : data.rows()) {
      int minutes = row.getInt("minutes");
      maxValue = max(maxValue, minutes);
      minValue = min(minValue, minutes);
    }
    
    for (int i = 0; i < data.getRowCount(); i++) {
      int minutes = data.getInt(i, "minutes");
      float x = map(i, 0, data.getRowCount() - 1, 50, width - 50);
      float y = map(minutes, 0, max(abs(maxValue), abs(minValue)), yAxisCenter, 50);
      if (minutes > 0) {
        y = map(minutes, 0, maxValue, yAxisCenter, 50);
      } else {
        y = map(minutes, minValue, 0, height - 50, yAxisCenter);
      }
      dataPoints.add(new DataPoint(x, y, minutes, i + 1));
    }
  }
  
  void update() {
    for (DataPoint dp : dataPoints) {
      dp.update();
    }
  }
  
  void display() {
    //Draw axis
    stroke(0);
    line(50, yAxisCenter, width - 50, yAxisCenter);
    line(50, 50, 50, height - 50);
    
    // Draw data points
    for (DataPoint dp : dataPoints) {
      dp.display();
    }
    
    //Adding labels
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Lecture Punctuality", width/2, 30);
    textSize(14);
    text("Lecture Days", width/2, height - 20);
    pushMatrix();
    translate(20, height/2);
    rotate(-HALF_PI);
    text("Minutes (Early/Late)", 0, 0);
    popMatrix();
    
    
    text("0", 40, yAxisCenter);
  }
  
  void interact(float mx, float my) {
    for (DataPoint dp : dataPoints) {
      dp.attract(mx, my);
    }
  }
  
  void click(float mx, float my) {
    for (DataPoint dp : dataPoints) {
      if (dp.isOver(mx, my)) {
        dp.isSelected = !dp.isSelected;
      } else {
        dp.isSelected = false;
      }
    }
  }
}

import processing.serial.*;

Serial myPort;
float[] data = new float[10000];
int index = 0;

void setup() {
  size(800, 400);
  myPort = new Serial(this, "COM5", 115200);  // Substitua 'COM3' pela sua porta serial
}

void draw() {
  background(255);
  stroke(0);
  noFill();
  beginShape();
  for (int i = 0; i < data.length; i++) {
    float x = map(i, 0, data.length, 0, width);
    float y = map(data[i], 0, 3.3, height, 0);  // Ajustando para o intervalo de 0 a 3.3V
    vertex(x, y);
  }
  endShape();
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    float voltage = float(inString);
    data[index] = voltage;
    index = (index + 1) % data.length;
  }
}

import processing.serial.*;

Serial myPort;
float[] data = new float[10000];
int index = 0;

void setup() {
  size(800, 400);
  myPort = new Serial(this, "COM5", 115200);  // Substitua 'COM3' pela sua porta serial
}

/*void draw() {
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
}*/

void draw() {
  background(255);
  
  // Desenha os eixos
  stroke(0);
  line(50, height - 50, width - 50, height - 50); // eixo x
  line(50, height - 50, 50, 50); // eixo y
  
  // Desenha labels nos eixos
  fill(0);
  textAlign(CENTER);
  
  // Labels do eixo x (tempo ou amostra)
  for (int i = 0; i <= 10; i++) {
    float x = map(i, 0, 10, 50, width - 50);
    text(i * (data.length / 10), x, height - 30);
    line(x, height - 55, x, height - 45);
  }
  
  // Labels do eixo y (tensão)
  textAlign(RIGHT);
  for (int i = 0; i <= 6; i++) {
    float y = map(i, 0, 6, height - 50, 50);
    text(i * 0.55, 40, y + 5);  // incrementos de 0.55V para cobrir 0 a 3.3V
    line(45, y, 55, y);
  }
  
  // Desenha o gráfico
  noFill();
  stroke(255, 0, 0);
  beginShape();
  for (int i = 0; i < data.length; i++) {
    float x = map(i, 0, data.length, 50, width - 50);
    float y = map(data[i], 0, 3.3, height - 50, 50);
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

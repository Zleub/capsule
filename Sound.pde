// require the beads library from the processing library store

import java.util.*; 
import beads.*;

AudioContext ac;

void settings() {
  size(300, 300);
}

void setup() {
  ac = new AudioContext();

  WavePlayer wp1 = new WavePlayer(ac, 220.f, Buffer.SINE);
  WavePlayer wp2 = new WavePlayer(ac, 221.f, Buffer.SINE);

  ac.out.addInput(new Mult(ac, wp1, wp2));
  ac.start();
}

color fore = color(255, 102, 204);
color back = color(0,0,0);

void draw() {
  loadPixels();

  Arrays.fill(pixels, back);
  for(int i = 0; i < width; i++) {  
    int buffIndex = i * ac.getBufferSize() / width;
    float vOffset = ac.out.getValue(0, buffIndex) * 10000;

    pixels[(int)(vOffset) + 150 * height + i] = fore;
  }
  updatePixels();
}

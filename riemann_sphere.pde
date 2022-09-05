//Project Riemann Sphere, uniting Riemann Surfaces and the Mandelbrot set
//Created by Sebastian Köller

import peasy.*; //PeasyCam library is licensed under Apache 2.0 license.

float resolution = 200;

//complex plane
float min = -2.0, max = 2.0;

//riemann sphere
float radius = 1.0;

Pixel[] plxls;
Pixel[] spxls;

PeasyCam cam;
PImage img;

boolean hidePlane = false;

void setup() {

  fullScreen(P3D);

  cam = new PeasyCam(this, width/2, height/2, 0, 500);

  initPlanePixels();
  initSpherePixels();

  img = loadImage("image.png");
}



void draw() {

  //Settings
  background(255);
  translate(width/2, height/2, 0);
  rotateX(HALF_PI);
  scale(100);
  strokeWeight(0.04);

  applyImageToPlane();

  //Graphics
  updateSpherePixels();
  //draw complex plane
  if (hidePlane == false) {
    for (Pixel plane : plxls) {
      plane.drawPixel();
    }
  }
  //draw riemann sphere
  for (Pixel sphere : spxls) {
    sphere.drawPixel();
  }
}

void initPlanePixels() {

  //Anzahl an Pixels bestimmen
  plxls = new Pixel[(int) (resolution * resolution)];

  //Objekte initialisieren
  for (int j = 0; j < plxls.length; j++) {

    plxls[j] = new Pixel();
  }

  //Attribute zuweisen
  int k = 0;
  float density = (abs(min) + abs(max)) / resolution;
  while (k < plxls.length) {
    for (int x = (int) (-resolution / 2); x < resolution / 2; x++) {
      for (int y = (int) (-resolution / 2); y < resolution / 2; y++) {
        plxls[k].setPosition(new PVector(x * density, y * density, 0));
        plxls[k].setColor(new PVector(0, 0, 0));
        k++;
      }
    }
  }
}

void initSpherePixels() {

  //Anzahl an Pixels bestimmen
  spxls = new Pixel[plxls.length];

  //Objekte initialisieren
  for (int j = 0; j < spxls.length; j++) {

    spxls[j] = new Pixel();
  }

  //Attribute zuweisen
  int k = 0;
  float density = (abs(min) + abs(max)) / resolution;
  while (k < plxls.length) {
    for (int x = (int) (-resolution / 2); x < resolution / 2; x++) {
      for (int y = (int) (-resolution / 2); y < resolution / 2; y++) {
        spxls[k].setPosition(calculateSpherePoint(new PVector(x * density, y * density, 0)));
        spxls[k].setColor(new PVector(0, 0, 0));
        k++;
      }
    }
  }
}

void updateSpherePixels() {

  for (int i = 0; i < spxls.length; i++) {
    spxls[i].setColor(plxls[i].rgb);
  }
}

void applyImageToPlane() {

  img.loadPixels();
  if (img.pixels.length == pow(resolution, 2)) {
    int i = 0;
    for (int x = 0; x < resolution; x++) {
      for (int y = 0; y < resolution; y++) {
        color c = img.get(x, y);
        plxls[i].setColor(new PVector(red(c), green(c), blue(c)));
        i++;
      }
    }
  }
  img.updatePixels();
}

PVector calculateSpherePoint(PVector planePoint) {

  float factor = 1.0 / (planePoint.x * planePoint.x + planePoint.y * planePoint.y + 1.0);

  float x = 2.0 * planePoint.x * factor;

  float y = 2.0 * planePoint.y * factor;

  float z = (planePoint.x * planePoint.x + planePoint.y * planePoint.y - 1.0) * factor;

  return new PVector(x, y, z);
}

void showCoordinates() {

  //x
  strokeWeight(0.07);
  stroke(255, 0, 0);
  line(0, 0, 0, 5, 0, 0);
  stroke(0, 255, 0);
  line(5, 0, 0, 7, 0, 0);

  //y
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 5, 0);
  stroke(255, 0, 0);
  line(0, 5, 0, 0, 7, 0);

  //z
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 5);
  stroke(100, 0, 255);
  line(0, 0, 5, 0, 0, 7);
}

void keyTyped() {

  if (key == 'p' || key == 'h') {
    if (hidePlane == false) {
      hidePlane = true;
    } else {
      hidePlane = false;
    }
  }
}

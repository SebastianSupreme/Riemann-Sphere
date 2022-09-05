

float radius(float x, float y, float z){
  return sqrt(x * x + y * y + z * z);
}

float theta(float y, float z){
  return acos(z / y);
}

float phi(float x, float y){
  return atan(y / x);
}

float x(float radius, float phi, float theta){
  return radius * sin(phi) * cos(theta);
}

float y(float radius, float phi, float theta){
  return radius * sin(phi) * sin(theta);
}

float z(float radius, float phi){
  return radius * cos(phi);
}

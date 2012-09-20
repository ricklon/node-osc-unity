/*
*
 * Unity3D control object
 * Potentiometer as joystick
 * button as firing
 * Rick Anderson
 */

#define pot1  A8
#define pot2  A9
#define pot3  A6
#define pot4  A7
#define but1  11
#define but2  10
#define accelX A1
#define accelY A2
#define accelZ A3


//Set the controler ID
const int controlID = 1;
// calibration result:  X(424,611)  Y(403,619)  Z(398,633
// Accelerometer... axis(min,max):    X(403,630)  Y(404,628)  Z(415,673 
const int minX = 397;
const int maxX = 630;
const int minY = 403;
const int maxY = 653;
const int minZ = 415;
const int maxZ = 806;

double xx;
double yy;
double zz;

double getAngle(int angA, int angB)
{
  double dd = RAD_TO_DEG * (atan2(-angA, -angB) + PI);
  return dd;  
}


void setup()
{
  Serial.begin(57600);
  pinMode(but1, INPUT);
  pinMode(but2, INPUT);

}

void loop()
{
  int joyX = analogRead(pot1);
  int joyY = analogRead(pot2);
  int camX = analogRead(pot3);
  int camY = analogRead(pot4);
  int accelXval = analogRead(accelX);
  int accelYval = analogRead(accelY);
  int accelZval = analogRead(accelZ);
  int but1val = digitalRead(but1);
  int but2val = digitalRead(but2);
  
  int angX = map(accelXval, minX, maxX, -90, 90);
  int angY = map(accelYval, minY, maxY, -90, 90);
  int angZ = map(accelZval, minZ, maxZ, -90, 90);
  
  xx = getAngle(angY, angZ);
  yy = getAngle(angX, angZ);
  zz = getAngle(angY, angX);
  

  Serial.print("{");
  Serial.print("\"controlID\" : ");
  Serial.print(controlID);
  Serial.print(", \"joyX\" : ");
  Serial.print(joyX);
  Serial.print(", \"joyY\" : ");
  Serial.print(joyY);
  Serial.print(", \"camX\" : ");
  Serial.print(camX);
  Serial.print(", \"camY\" : ");
  Serial.print(camY);
  Serial.print(", \"but1\" : ");
  Serial.print(but1val);
  Serial.print(", \"but2\" : ");
  Serial.print(but2val); 
  
  Serial.print(", \"accelX\" : ");
  Serial.print(accelXval);
  Serial.print(", \"accelY\" : ");
  Serial.print(accelYval);
  Serial.print(", \"accelZ\" : ");
  Serial.print(accelZval); 
  
  Serial.print(", \"angX\" : ");
  Serial.print(angX);
  Serial.print(", \"angY\" : ");
  Serial.print(angY);
  Serial.print(", \"angZ\" : ");
  Serial.print(angZ); 

/*
  Serial.print(", \"radXval\" : ");
  Serial.print(xx);
  Serial.print(", \"radYval\" : ");
  Serial.print(zz);
  Serial.print(", \"radZval\" : ");
  Serial.print(yy); 

*/
  Serial.println("}");
  delay(20);

}


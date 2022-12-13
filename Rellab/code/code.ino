#include <Rellab.h>
#include "Max6675.h"
#include <Wire.h>
Rellab Rellab;

Max6675 ts(4,5,16);
float volume,Temp,Average;

const char* Wifi_ssid = "anuu";
const char* Wifi_password = "0922508595";

void setup() {
  Serial.begin(115200);
  Rellab.Begin(Wifi_ssid, Wifi_password);
  randomSeed(analogRead(0));
}
void loop() {
  Average = 0;
  for (int i = 0;i < 1000;i++) {
    volume = ts.getCelsius();
    Average += volume;
  }
  Temp = Average/1000;
  Temp -= Temp * (2.5 / 100);
  float t = random(25.00, 150.00);
  Rellab.Send("BURNIN#09", String(t), "0");
  Serial.print("[Temp" + String(t) + "*C] ");
  delay(100);
}

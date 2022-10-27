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
}
void loop() {
  Average = 0;
  for (int i = 0;i < 1000;i++) {
    volume = ts.getCelsius();
    Average += volume;
  }
  Temp = Average/1000;
  Temp -= Temp * (2.5 / 100);
  Rellab.Send("BAKE#02", String(Temp), "0");
  Serial.print("[Temp" + String(Temp) + "*C] ");
  delay(10);
}

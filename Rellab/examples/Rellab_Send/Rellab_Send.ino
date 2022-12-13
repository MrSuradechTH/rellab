#include <Rellab.h>
Rellab Rellab;

const char* Wifi_ssid = "wifi_ssid";
const char* Wifi_password = "wifi_password";

void setup() {
  Serial.begin(115200);
  Rellab.Begin(Wifi_ssid, Wifi_password);
}
void loop() {
  Rellab.Send("machine_name", "temp", "humid");
}
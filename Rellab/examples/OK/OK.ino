#include <Rellab.h>
#include "Adafruit_MAX31855.h"
Rellab Rellab;

#define DO   12
#define CS   15
#define CLK  14
Adafruit_MAX31855 thermocouple(CLK, CS, DO);

const char* Wifi_ssid = "anuu";
const char* Wifi_password = "0922508595";

void setup() {
  Serial.begin(115200);
  Rellab.Begin(Wifi_ssid, Wifi_password);
}
void loop() {
  int i = 0;
  double internalTemp = thermocouple.readInternal(),rawTemp = thermocouple.readCelsius(),thermocoupleVoltage= 0,internalVoltage = 0,correctedTemp = 0;
  if (isnan(rawTemp)) {
    Serial.println("Something wrong with thermocouple!");
  }else {
    thermocoupleVoltage = (rawTemp - internalTemp)*0.041276;
    if (internalTemp >= 0) {
      double c[] = {-0.176004136860E-01,  0.389212049750E-01,  0.185587700320E-04, -0.994575928740E-07,  0.318409457190E-09, -0.560728448890E-12,  0.560750590590E-15, -0.320207200030E-18,  0.971511471520E-22, -0.121047212750E-25};
      int cLength = sizeof(c) / sizeof(c[0]);
      double a0 =  0.118597600000E+00;
      double a1 = -0.118343200000E-03;
      double a2 =  0.126968600000E+03;
  
      for (i = 0; i < cLength; i++) {
        internalVoltage += c[i] * pow(internalTemp, i);
      }
      internalVoltage += a0 * exp(a1 * pow((internalTemp - a2), 2));
    }else if (internalTemp < 0) {
      double c[] = {0.000000000000E+00,  0.394501280250E-01,  0.236223735980E-04, -0.328589067840E-06, -0.499048287770E-08, -0.675090591730E-10, -0.574103274280E-12, -0.310888728940E-14, -0.104516093650E-16, -0.198892668780E-19, -0.163226974860E-22};
      int cLength = sizeof(c) / sizeof(c[0]);
      for (i = 0; i < cLength; i++) {
        internalVoltage += c[i] * pow(internalTemp, i) ;
      }
    }
      
    double totalVoltage = thermocoupleVoltage + internalVoltage;
    if (totalVoltage < 0) {
      double d[] = {0.0000000E+00, 2.5173462E+01, -1.1662878E+00, -1.0833638E+00, -8.9773540E-01, -3.7342377E-01, -8.6632643E-02, -1.0450598E-02, -5.1920577E-04, 0.0000000E+00};
      int dLength = sizeof(d) / sizeof(d[0]);
      for (i = 0; i < dLength; i++) {
        correctedTemp += d[i] * pow(totalVoltage, i);
      }
    }else if (totalVoltage < 20.644) {
      double d[] = {0.000000E+00, 2.508355E+01, 7.860106E-02, -2.503131E-01, 8.315270E-02, -1.228034E-02, 9.804036E-04, -4.413030E-05, 1.057734E-06, -1.052755E-08};
      int dLength = sizeof(d) / sizeof(d[0]);
      for (i = 0; i < dLength; i++) {
        correctedTemp += d[i] * pow(totalVoltage, i);
      }
    }else if (totalVoltage < 54.886 ) {
      double d[] = {-1.318058E+02, 4.830222E+01, -1.646031E+00, 5.464731E-02, -9.650715E-04, 8.802193E-06, -3.110810E-08, 0.000000E+00, 0.000000E+00, 0.000000E+00};
      int dLength = sizeof(d) / sizeof(d[0]);
      for (i = 0; i < dLength; i++) {
        correctedTemp += d[i] * pow(totalVoltage, i);
      }
    } else {
      Serial.print("Temperature is out of range. This should never happen.");
      correctedTemp = NAN;
    }
    Rellab.Send("TEMPHUMID", String(correctedTemp), "0");
    Serial.print("[Temp" + String(correctedTemp) + "*C] ");
  }
  delay(10);
}

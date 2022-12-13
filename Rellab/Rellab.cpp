#include <Rellab.h>
#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

ESP8266WiFiMulti WiFiMulti;

Rellab::Rellab() {
  
}

void Rellab::Begin(const char* wifi_ssid, const char* wifi_password) {
  _wifi_ssid = wifi_ssid;
  _wifi_password = wifi_password;
  
  Serial.println("Welcome to Rellab");

  pinMode(LED_BUILTIN, OUTPUT);

//  for (uint8_t t = 4; t > 0; t--) {
//    Serial.printf("[SETUP] WAIT %d...\n", t);
//    Serial.flush();
//    delay(1000);
//  }
  WiFi.mode(WIFI_STA);
  Serial.print("Wifi Connecting");
  while((WiFiMulti.run() != WL_CONNECTED)) {
    Serial.print(".");
    WiFiMulti.addAP(_wifi_ssid, _wifi_password);
    delay(500);
  }
  Serial.println("");
  Serial.println("Wifi Connected");
}

void Rellab::Send(String _name, String _temp, String _humid) {
  if ((WiFiMulti.run() == WL_CONNECTED)) {
    WiFiClient client;
    HTTPClient http;
    
//    String url = "http://192.168.149.212/data_transmission.php?username=MrSuradechTH&value=" + String(value); //get
//    String url = "http://192.168.43.126/data_transmission.php"; //post
    http.begin(client,_server);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded"); //เปิดเมื่อ post ปิดเมื่อ get

//    int httpCode = http.GET(); //get
    //int httpCode = http.POST("username=" + _perdpro_username + "&" + "password=" + _perdpro_password + "&" + value_name + "=" + value_num + "&mode=SEND"); //post
	// Serial.print("mode=" + _mode + "&name=" + _name + "&temp=" + _temp + "&humid=" + _humid);
	// int httpCode = http.POST("mode=SEND&username=" + _perdpro_username + "&" + "password=" + _perdpro_password + "&" + "api_name=" + api_name + "&" + "api_value=" + api_value); //post
	int httpCode = http.POST("mode=" + _mode + "&name=" + _name + "&temp=" + _temp + "&humid=" + _humid); //post
	Serial.print("STATUS[SEND] : ");
    if (httpCode > 0) {
//      Serial.printf("[HTTP] GET... code: %d\n", httpCode); //show code
      Serial.println("success");
      digitalWrite(LED_BUILTIN, HIGH);
      delay(10);
      digitalWrite(LED_BUILTIN, LOW);
      //if (httpCode == 302) {
        //Serial.println("success");
      //}else {
        //Serial.println("fail same value");
     // }
      //if (httpCode == HTTP_CODE_OK) {
        //String payload = http.getString();
        //Serial.println(payload);
      //}
    } else {
      Serial.println("fail");
      //Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str()); //show error
    }
    http.end();
  }else {
    Serial.println("Wifi Disconnected");
    Serial.print("Wifi Reconnecting");
    while((WiFiMulti.run() != WL_CONNECTED)) {
      Serial.print(".");
      WiFiMulti.addAP(_wifi_ssid, _wifi_password);
      delay(500);
    }
    Serial.println("");
    Serial.println("Wifi Connected");
  }
}
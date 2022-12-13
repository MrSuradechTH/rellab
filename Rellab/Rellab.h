#include <Arduino.h>

class Rellab {
  private:
    const char* _wifi_ssid;
    const char* _wifi_password;
    String _server = "http://172.20.10.3/json.php";
    String _mode = "update";

  public:
    Rellab();
    void Begin(const char* wifi_ssid, const char* wifi_password);
    void Send(String _name, String _temp, String _humid);
    //void Recive();
};
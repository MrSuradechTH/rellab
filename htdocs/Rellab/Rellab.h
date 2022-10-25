#include <Arduino.h>

class Rellab {
  private:
    const char* _wifi_ssid;
    const char* _wifi_password;
    String _server = "http://127.0.0.1";
    String _mode;
    String _name;

  public:
    Rellab();
    void Begin(const char* wifi_ssid, const char* wifi_password);
    void Send(String value_name, String value_num);
    //void Recive();
};
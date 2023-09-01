// please open serial potter to see the sine wave~

#include "math.h"



void setup() {

  Serial.begin(9600);

}



void loop() {

  for (double i = -10.0; i <= 10.0 ; i += 0.1) {

    Serial.println(pow(i, 2) + 2 * i + 1);

    delay(10);

  }

}

double freq = 500;    //Square wave frequency(s)
int sqwPin = 13;

unsigned int period,periodHalf;
unsigned long microseconds;
bool ledState = LOW;

void setup() {
  Serial.begin(115200);
  pinMode(sqwPin,OUTPUT);

  period = round(1000000*(1.0/freq));   //(s) into (\mus)
  periodHalf = period/2;
}

void loop() {
//  tone(sqwPin, freq);    //Arduino function to create square wave
    
  microseconds = micros();    //Overflows after around 70 minutes!

    while(micros() < (microseconds + periodHalf)){
      ledState = HIGH;
      digitalWrite(sqwPin,ledState);
      Serial.println(ledState);
  //  delay(periodHalf);
    }    //50% Duty cycle

    while(micros() < (microseconds + period)){
      ledState = LOW;
      digitalWrite(sqwPin,ledState);
      Serial.println(ledState);
  //   delay(periodHalf);
    }
}
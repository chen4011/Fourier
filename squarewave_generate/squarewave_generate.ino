double freq = 500;    //Square wave frequency(s)
int sqwPin = 13;

unsigned int period,periodHalf;
unsigned long microseconds;

void setup() {
  Serial.begin(115200);
  pinMode(sqwPin,OUTPUT);

  period = round(1000000*(1.0/freq));   //(s) into (\mus)
  periodHalf = period/2;
}

void loop() {
//  tone(sqwPin, freq);    //Arduino function to create square wave
    
  while(1){
      microseconds = micros();    //Overflows after around 70 minutes!

      digitalWrite(sqwPin,HIGH);
//      delay(periodHalf);

      while(micros() < (microseconds + periodHalf)){}    //50% Duty cycle

      digitalWrite(sqwPin,LOW);
//      delay(periodHalf);

      while(micros() < (microseconds + period)){}
  }
}

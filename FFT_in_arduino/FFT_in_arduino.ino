#include "arduinoFFT.h"
 
#define SAMPLES 128             //Must be a power of 2
#define SAMPLING_FREQUENCY 2000 //Hz(s^-1), must be less than 10000 due to ADC
 
arduinoFFT FFT = arduinoFFT();
 
unsigned int sampling_period_us;
unsigned long microseconds;
 
double vReal[SAMPLES];
double vImag[SAMPLES];
 
void setup() {
    Serial.begin(115200);
 
    sampling_period_us = round(1000000*(1.0/SAMPLING_FREQUENCY));   //(s) into (\mus)
}
 
void loop() {
   
    /*SAMPLING*/
    for(int i=0; i<SAMPLES; i++)
    {
        microseconds = micros();    //Overflows after around 70 minutes!
     
        vReal[i] = analogRead(A0);
        vImag[i] = 0;
//        Serial.println(vReal[i]*5/1023);
     
        while(micros() < (microseconds + sampling_period_us)){
        }
    }
 
    /*FFT*/
    FFT.Windowing(vReal, SAMPLES, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
    FFT.Compute(vReal, vImag, SAMPLES, FFT_FORWARD);    //compute the FFT
    FFT.ComplexToMagnitude(vReal, vImag, SAMPLES);    //compute the magnitude from the real and imaginary vectors
    double peak = FFT.MajorPeak(vReal, SAMPLES, SAMPLING_FREQUENCY);    //compute the frequency with the highest magnitude
 
    /*PRINT RESULTS*/
    /*print the peak*/
    Serial.print("peak :");
    Serial.println(peak);     //Print out what frequency is the most dominant.
    /*print all of the resulats*/
    for(int i=0; i<(SAMPLES/2); i++)
    {
        /*View all these three lines in serial terminal to see which frequencies has which amplitudes*/
         
        Serial.println((i * 1.0 * SAMPLING_FREQUENCY) / SAMPLES, 1);    //calculates the frequency increment per bin
        Serial.print(" ");
        Serial.println(vReal[i], 1);    //View only this line in serial plotter to visualize the bins
    }
//    /*print the picture*/
//    for(int i=0; i<(SAMPLES/2); i++)
//    {
//        /*View all these three lines in serial terminal to see which frequencies has which amplitudes*/
//        Serial.println(vReal[i], 1);    //View only this line in serial plotter to visualize the bins
//    }
 
//    delay(1000);  //Repeat the process every second OR:
    while(1);       //Run code once
}

//adapted from https://gist.github.com/timpulver/5ba4a29cddd543b4a900  tyty

void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensorValue = analogRead(A0);
  Serial.println(sensorValue);
  delay(1);        // delay in between reads for stability
}

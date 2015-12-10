import processing.serial.*;

Serial sensor;
int buttonValue = 0;
String text = "";

void setup() {
	size(256, 256);
	sensor = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
	background(64,64, 226);
	PFont f = createFont(PFont.list()[593], 48);
	textFont(f);
	fill(0);
	text(text, width / 2 - 32, height/ 8 + 16);
	fill(255, 0, 0);
	while (sensor.available() > 0) {
		byte[] buffer = new byte[sensor.available() + 2];
		sensor.readBytesUntil(10, buffer);
		text = new String(buffer);
		text= text.substring(0,2);
		try {
			int v = Integer.parseInt(text);
			rect(width / 2 - height / 16, height - v * 2, height /8, height);
		}	catch(NumberFormatException e) {
		}
	}
}

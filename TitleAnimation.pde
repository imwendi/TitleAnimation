import gifAnimation.*;

String[][] strs = new String[3][2];
PFont font;
GIF g;

void setup() {
  g = new GIF(this, "wendi_animation.gif");

  size(1920, 500);
  font = createFont("manrope-bold.ttf", 48);

  textFont(font);
  frameRate(30);
  textAlign(CENTER);
  textSize(40);
  background(255);
  fill(0);

  strs[0][0] = "G'day, nice to meet you!";
  strs[0][1] = "I'm Wendi Ma.";

  strs[1][0] = "I'm studying Mathematics and Mechatronics";
  strs[1][1] = "at the University of Queensland.";

  strs[2][0] = "I'm passionate about using maths to solve problems,";
  strs[2][1] = "particularly with deep learning!";
}

int i = 0;
boolean delete = false;
int s = 0;
int offset = 50;
int mainFontSize = 60;
int secondaryFontSize = 47;

// Animation things
int frameDelay = 1000/30;
int pageDelay = 3500;
long lastTimeStamp = System.currentTimeMillis();
boolean paused = false;


void draw() {
  background(255);

  if (s < strs.length) {
    if (!delete) {
      // Render text
      if (strs[s][0].length() >= i) {
        textSize(mainFontSize);
        text(strs[s][0].substring(0, i), width/2, height/2 - offset);
      } else {
        textSize(mainFontSize);
        text(strs[s][0], width/2, height/2 - offset);
      }
      if (strs[s][1].length() >= i) {
        textSize(secondaryFontSize);
        text(strs[s][1].substring(0, i), width/2, height/2 + offset);
      } else {
        textSize(secondaryFontSize);
        text(strs[s][1], width/2, height/2 + offset);
      }

      // Handle pausing between pages
      if (strs[s][0].length() >= i || strs[s][1].length() >= i) {
          g.addFrame(frameDelay);
          i++;
      } else if (!paused) {
          // Initialize pause between "pages" of text
          paused = true;
          lastTimeStamp = System.currentTimeMillis();
      } else if (paused && System.currentTimeMillis() < lastTimeStamp +
            pageDelay) {
          // Save the paused frame until the pause is over
        g.addFrame(frameDelay);
      } else {
          // End pause and toggle delete
          paused = false;
          delete = true;
      }
    }

    if (delete) {
      if (i > 0) {
        if (i < strs[s][0].length()) {
          textSize(mainFontSize);
          text(strs[s][0].substring(0, i - 1), width/2, height/2 - offset);
        } else {
          textSize(mainFontSize);
          text(strs[s][0], width/2, height/2 - offset);
        }
        if (i < strs[s][1].length()) {
          textSize(secondaryFontSize);
          text(strs[s][1].substring(0, i - 1), width/2, height/2 + offset);
        } else {
          textSize(secondaryFontSize);
          text(strs[s][1], width/2, height/2 + offset);
        }
        i--;
        g.addFrame(frameDelay);
      } else {
        delete = false;
        s++;
      }
    }

  } else {
      // Save gif
      g.addFrame(3500);
      g.save();
    
      // Repeat animation
      s = 0;
      delay(3500);
  }
}

/* Class from: https://sighack.com/post/make-animated-gifs-in-processing */
class GIF {
  GifMaker gif;
  GIF(PApplet app, String filename) {
    gif = new GifMaker(app, filename, 100);
    gif.setRepeat(0); // 0 means endless loop
  }

  void addFrame(int delay_in_frames) {
    gif.setDelay(delay_in_frames);
    gif.addFrame();
  }

  void save() {
    gif.finish();
    println("GIF exported!");
  }
};

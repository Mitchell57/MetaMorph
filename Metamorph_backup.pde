/**
 * Metamorph
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 

import controlP5.*;
import java.util.*;
import java.awt.*;
import javax.swing.*;

ControlP5 cp5;
PImage img, displayImg, back;
PFont font;
Textlabel tl;
ScrollableList sl;
MorphHandler mh;
Group ig;
final JFrame frame = new JFrame("Progress");
final JProgressBar pb = new JProgressBar();


void setup() {
  // Initialization
  size(1100, 800);
  cp5 = new ControlP5(this);
  ig = new Group(cp5, "initGroup").setLabel("");
  font = createFont("HelveticaNeue", 14, true);
  cp5.setFont(font, 12);
  img = loadImage("default.jpg");
  mh = new MorphHandler();
  
  
  // GUI Core Layout - Load, Save, Resolution
  cp5.addButton("bLoad")
    .setPosition(810, 10)
    .setSize(280, 28)
    .setLabel("Load Image")
    ;
    
  cp5.addButton("bSave")
    .setPosition(810, 40)
    .setSize(280, 28)
    .setLabel("Save Image")
    ;
    
  java.util.List l = Arrays.asList(mh.getMorphs());
  sl = cp5.addScrollableList("morphSelector")
     .setPosition(810, 80)
     .setSize(280, 200)
     .setBarHeight(28)
     .setItemHeight(28)
     .setLabel("Choose Morph")
     .addItems(l)
     ;
  
    
  tl = cp5.addTextlabel("resolutionLabel")
    .setPosition(810, 760)
    .setWidth(280)
    .setHeight(40)
    .setText("Preview Resolution: 800x800\nOriginal Resolution: 800x800")
    .setFont(font)
    .setColor(0)
    .setLineHeight(18)
    ;
   
  cp5.addTextlabel("initLabel2")
        .setPosition(810, 300)
        .setGroup("initGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Press C to clear values")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;

}

// Called when load button is released, opens dialog to choose file, passes to imageChosen()
void bLoad(){
  selectInput("Select an image", "imageChosen");
}

void imageChosen( File f )
{
  if( f.exists() )
  {
     if(img!=null) back = img.get();
     img = loadImage( f.getAbsolutePath() );
     // Updates resolution label
     String resolution = img.width + "x" + img.height;
     tl.setText("Preview Resolution: 800x800\nOriginal Resolution: "+resolution);
  }
}

// Called when save button is released, opens dialog to choose filename, passes to fileSelected()
void bSave(){
  if(img != null){
    selectOutput("Select a file to write to:", "fileSelected");
  }
}

// saves current img to specified filename as .jpg
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    
    // ensures it will save as .jpg
    String fileName = selection.getAbsolutePath();
    if(!fileName.endsWith(".jpg")){
      fileName += ".jpg";
    }
    
    img.save(fileName);
  }
}

void morphSelector(int n){
   String morphName = mh.getMorphs()[n];
   mh.loadMorph(morphName);
}

void draw() {
  background(220);
  if(img != null){
    
      //checks for smoothing preferences
      //previews a copy of img that fits the display
      displayImg = img.get();
      if(img.width > 800 || img.height > 800){
        if(img.width >= img.height){
          displayImg.resize(800, 0);
        }
        else{
          displayImg.resize(0, 800);
        }
      }
      
      //draws preview image
      image(displayImg, 0, 0);
      
  }
  
  
}

void keyPressed(){
    if(key == 'c' || key == 'C'){
       mh.clear();
    }
  }
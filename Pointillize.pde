/**
 * Pointillize implementation
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
 import java.util.*;
 import java.lang.*;
 
 public class Pointillize implements Morph {
  Group pg = new Group(cp5, "ptzGroup").setLabel("");
  float ptzSlide1;
  Slider sl1, sl2; 
  Range range;
  CheckBox checkbox, checkbox2;
  int endIndex, sizeMin, sizeMax;
  boolean sizeByBright, r1, r2;
  
  public Pointillize(){
    
    // GUI Init
    int startIndex = 150;
    cp5.addTextlabel("ptzLabel1")
        .setPosition(810, startIndex)
        .setGroup("ptzGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Make circle for every _ points")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
     
     sl1 = cp5.addSlider("ptzSlide1")
       .setGroup("ptzGroup")
       .setSize(280, 48)
       .setPosition(810, startIndex+20)
       .plugTo(this)
       .setRange(1, 100)
       .setNumberOfTickMarks(100)
       .showTickMarks(false)
       .setValue(10)
       ;
     
     cp5.addTextlabel("ptzLabel2")
        .setPosition(810, startIndex+100)
        .setGroup("ptzGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Range for circle sizes:")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;  
       
     range = cp5.addRange("rangeController")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setGroup("ptzGroup")
             .setPosition(810,startIndex+120)
             .setSize(280,48)
             .plugTo(this)
             .setHandleSize(20)
             .setRange(1,250)
             .setRangeValues(20,100)
             .setNumberOfTickMarks(250) 
             .showTickMarks(false)
             .snapToTickMarks(true)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)  
             ;
     
     checkbox = cp5.addCheckBox("checkBox")
                .setPosition(810, startIndex+180)
                .setSize(40, 40)
                .setGroup("ptzGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(0)
                .addItem("Size by Brightness", 0)
                .setColorLabel(#000000)
                ;
     checkbox2 = cp5.addCheckBox("checkBox2")
                .setPosition(860, startIndex+220)
                .setSize(20, 20)
                .setGroup("ptzGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(5)
                .addItem("Reverse Sort", 0)
                .addItem("Reverse Size", 1)
                .setColorLabel(#000000)
                ;
     
     
     // Variable Init
     pg.setVisible(false);
     sizeByBright = false;
     r1 = false;
     r2 = false;
     ptzSlide1 = 0;
     sizeMin=50;
     sizeMax=100;
     endIndex = startIndex+300;
     println("Pointillize init");
  }
  
  
  // Executes when "Morph" is pressed, takes pixel[] of current img and returns pointillized version
  int[] apply(int[] pixels){
    Vector v = new Vector();
    int w = img.width;
    int h = img.height;
    PGraphics pg = createGraphics(w, h);
    colorMode(RGB);
    for(int i=0; i<h; i+=ptzSlide1){
      for(int j=0; j<w; j+=ptzSlide1){
        color c = pixels[i*w+j];
        v.addElement(new Point(j, i, c)); 
      }
    }
    int len = v.size();
    pg.beginDraw();
    pg.noStroke();
    
    if(sizeByBright){
      if(!r1) 
        Collections.sort(v, new SortByBrightA());
      else Collections.sort(v, new SortByBrightD());
      int sizeRange = constrain(sizeMax - sizeMin, 1, 250);
      int cycle = v.size() / sizeRange;
      int size;
      if(!r2) size = sizeMax;
      else size = sizeMin;
      int count = 0;
      
      for(int i=0; i<v.size(); i++){
        if(count < cycle){
           count++;
        }
        else{
         if(!r2) size --;
         else size ++;
         count = 0;
        }
        Point p = (Point)v.get(i); 
        pg.fill(p.col);
        pg.ellipse(p.x, p.y, size, size);
        pb.setValue(floor((((float)i)/((float)v.size()))*100));
      }   
    } 
      
      
    
    else{
      while(!v.isEmpty()){
        int index = (int)random(v.size()-1);
        Point p = (Point)v.get(index);
        pg.fill(p.col);
        int size = (int)random(sizeMin, sizeMax);
        pg.ellipse(p.x, p.y, size, size);
        v.removeElementAt(index);
         
        // Progress Bar
        pb.setValue(100-floor(((float)(v.size())/len)*100));
      }
    }
    pg.endDraw();
    frame.setVisible(false);
    return pg.pixels; 
  }
  
  // Listeners for GUI elements
  
  void controlEvent(ControlEvent theControlEvent) {
    if(theControlEvent.isFrom("rangeController")) {
      // min and max values are stored in an array.
      // access this array with controller().arrayValue().
      // min is at index 0, max is at index 1.
      sizeMin = int(theControlEvent.getController().getArrayValue(0));
      sizeMax = int(theControlEvent.getController().getArrayValue(1));
    }
  }
  
  void ptzSlide1(){
    if(sl1 != null){
      ptzSlide1 = sl1.getValue();
    }
  }
  
  void checkBox(float a[]){
    if(a[0] == 1) sizeByBright = true; 
    else sizeByBright = false;
  }
  
  void checkBox2(float a[]){
    if(a[0] == 1) r1 = true; 
    else r1 = false;
    
    if(a[1] == 1) r2 = true; 
    else r2 = false;

  }
  
  // Internal Utils
  
  void clearVals(){
    float val = 10.0;
    if(sl1 != null){
      sl1.setValue(val);
    }
    
    if(range != null){
      range.setRangeValues(20,100);
    }
    float[] val1 = {0};
    float[] val2 = {0,0};
    
    checkbox.setArrayValue(val1);
    checkbox2.setArrayValue(val2);
    
    r1 = false;
    r2 = false;
  }
  
  int getEnd(){
    return endIndex; 
  }
  
  void load(){
    pg.setVisible(true); 
  }
  
  void hide(){
    pg.setVisible(false);  
  }
  
 }
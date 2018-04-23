/**
 * Morph interface, Point class, and comparators
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
 import milchreis.imageprocessing.*;
 
  public class Tweak implements Morph {
   int endIndex, brightLevel, bloomLevel, quantLevel;
   Group twg = new Group(cp5, "tweakGroup").setLabel("");
   Slider bright, bloom, quant;
   CheckBox sobel, brightBox, bloomBox, quantBox;
   boolean sobelBool = false, brightBool = false, bloomBool = false, quantBool = false;
   
   public Tweak(){
     int startIndex = 150;
     
     cp5.addTextlabel("twkLabel1")
        .setPosition(810, startIndex)
        .setGroup("tweakGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Brightness")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
        
     brightBox = cp5.addCheckBox("brightBox")
                .setPosition(810, startIndex+30)
                .setSize(30, 28)
                .setGroup("tweakGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(0)
                .addItem("", 0)
                .setColorLabel(#000000)
                ;
     
     bright = cp5.addSlider("brightness")
       .setGroup("tweakGroup")
       .setSize(240, 48)
       .setPosition(850, startIndex+20)
       .plugTo(this)
       .setRange(-255, 255)
       .setLabel(" ")
       .setNumberOfTickMarks(561)
       .showTickMarks(false)
       .setDefaultValue(0)
       ;
       
     cp5.addTextlabel("twkLabel2")
        .setPosition(810, startIndex+80)
        .setGroup("tweakGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Bloom")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
        
     bloomBox = cp5.addCheckBox("bloomBox")
                .setPosition(810, startIndex+110)
                .setSize(30, 28)
                .setGroup("tweakGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(0)
                .addItem("\n", 0)
                .setColorLabel(#000000)
                ;
     
     bloom = cp5.addSlider("bloomness")
       .setGroup("tweakGroup")
       .setSize(240, 48)
       .setPosition(850, startIndex+100)
       .plugTo(this)
       .setRange(0, 255)
       .setLabel("")
       .setNumberOfTickMarks(256)
       .showTickMarks(false)
       .setDefaultValue(0)
       ;
       
     cp5.addTextlabel("twkLabel3")
        .setPosition(810, startIndex+160)
        .setGroup("tweakGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Quantize")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
     
     quant = cp5.addSlider("quantize")
       .setGroup("tweakGroup")
       .setSize(240, 48)
       .setPosition(850, startIndex+180)
       .plugTo(this)
       .setRange(1, 30)
       .setLabel("")
       .setNumberOfTickMarks(20)
       .showTickMarks(false)
       .setDefaultValue(1)
       ;
       
    quantBox = cp5.addCheckBox("quantBox")
                .setPosition(810, startIndex+190)
                .setSize(30, 28)
                .setGroup("tweakGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(0)
                .addItem("\n\n", 0)
                ;
       
     sobel = cp5.addCheckBox("sobel")
                .setPosition(810, startIndex+240)
                .setSize(40, 40)
                .setGroup("tweakGroup")
                .plugTo(this)
                .setItemsPerRow(1)
                .setSpacingColumn(0)
                .setSpacingRow(0)
                .addItem("Sobel Edge Detector", 0)
                .setColorLabel(#000000)
                ;
     
     
     endIndex = 530;
     brightLevel = 0;
     bloomLevel = 0;
     twg.setVisible(false);
     println("Tweak init");
   }
   
   void load(){
     twg.setVisible(true);
   }
   void hide(){
     twg.setVisible(false);
   }
   int[] apply(int[] pixels){
     PImage processedImg = createImage(img.width, img.height, RGB);
     processedImg.pixels = pixels.clone();
     
     if(brightBool)processedImg = Brightness.apply(processedImg, brightLevel);
     if(bloomBool)processedImg = Bloom.apply(processedImg, bloomLevel, bloomLevel);
     if(quantBool)processedImg = Quantization.apply(processedImg, quantLevel);
     if(sobelBool) processedImg = SobelEdgeDetector.apply(processedImg);
     frame.setVisible(false);
     return processedImg.pixels;
   }
   
   void brightness(){
     if(bright != null){
       brightLevel = round(bright.getValue());
     }
   }
   
   void bloomness(){
      if(bloom != null){
        bloomLevel = round(bloom.getValue());
      }
   }
   
   void quantize(){
      if(quant != null){
        quantLevel = round(quant.getValue());
      }
   }
   
   void sobel(float a[]){
     if(a[0] == 1) sobelBool = true; 
     else sobelBool = false;
  }
  
  void brightBox(float a[]){
     if(a[0] == 1) brightBool = true; 
     else brightBool = false;
  }
  
  void bloomBox(float a[]){
     if(a[0] == 1) bloomBool = true; 
     else bloomBool = false;
  }
  
  void quantBox(float a[]){
     if(a[0] == 1) quantBool = true; 
     else quantBool = false;
  }
   
   void clearVals(){
     bright.setValue(0);
     bloom.setValue(0);
     quant.setValue(1);
     float[] fA = {0};
     sobel.setArrayValue(fA);
     brightBox.setArrayValue(fA);
     bloomBox.setArrayValue(fA);
     quantBox.setArrayValue(fA);
     sobelBool = false;
     brightBool = false;
     bloomBool = false;
     quantBool = false;
   }
   
   int getEnd(){
     return endIndex;
   }
   
   
   
  }
  
  
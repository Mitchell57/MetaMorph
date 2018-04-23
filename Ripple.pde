/**
 * Ripple implementation
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
 public class Ripple implements Morph {
   Group rg = new Group(cp5, "rippleGroup").setLabel("");
   float slide, slide2;
   Slider sl, sl2;
   int endIndex;
   
   public Ripple(){
     
     cp5.addTextlabel("label1")
        .setPosition(810, 330)
        .setGroup("rippleGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Twirl Amount")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
        
     sl = cp5.addSlider("slide")
       .setGroup("rippleGroup")
       .setSize(280, 48)
       .setPosition(810, 350)
       .plugTo(this)
       .setRange(-100, 100)
       .setNumberOfTickMarks(201)
       .showTickMarks(false)
       .setDefaultValue(0)
       ;
       
     cp5.addTextlabel("label2")
      .setPosition(810, 430)
      .setGroup("rippleGroup")
      .setWidth(280)
      .setHeight(40)
      .setText("Repetitions")
      .setFont(font)
      .setColor(0)
      .setLineHeight(18)
      ;
        
     sl2 = cp5.addSlider("slide2")
       .setGroup("rippleGroup")
       .setSize(280, 48)
       .setPosition(810, 450)
       .plugTo(this)
       .setRange(0,10)
       .setNumberOfTickMarks(11)
       .showTickMarks(false)
       .setDefaultValue(5)
       ;
     
     
     rg.setVisible(false);
     endIndex = 500;
     println("Ripple init");
   }
   
   
   void load(){
     rg.setVisible(true);
   }
   
   void hide(){
     rg.setVisible(false);
   }
   
   int[] twirl(int[] pixels, float val){
     int w = img.width;
     int h = img.height;
     
     float cX = (float)w/2.0;
     float cY = (float)h/2.0;
     float maxRadius = sqrt(cX*cX+cY*cY);
     
     float factor = val;
     
     int[] pCopy = pixels.clone();
     
     for(int i=0; i<h; i++){
       float relY = cY - i;
       
       for(int j=0; j<w; j++){
          float relX = j-cX;
          float ogAngle;
          
          if(relX != 0){
            ogAngle = atan(abs(relY)/abs(relX));
            
            if(relX>0 && relY<0) ogAngle = 2.0f*PI - ogAngle;
            else if(relX<=0 && relY>=0) ogAngle = PI - ogAngle;
            else if(relX<=0 && relY<0) ogAngle += PI;
            
          }
          else{
            if(relY >= 0) ogAngle = 0.5f * PI;
            else ogAngle = 1.5f * PI;
          }
          
          float radius = sqrt(relX*relX + relY*relY);
          float amt = (maxRadius - radius) / maxRadius;
          float newAngle = ogAngle + amt*(factor/(0.1*radius+(4.0f/PI)));
          
          int srcX = (int)(floor(radius * cos(newAngle)+0.5f));
          int srcY = (int)(floor(radius * sin(newAngle)+0.5f));
          
          srcX += cX;
          srcY += cY;
          srcY = h - srcY;
          
          if(srcX < 0) srcX = 0;
          else if(srcX >= w) srcX = w-1;
          if(srcY < 0) srcY = 0;
          else if(srcY >= h) srcY = h-1;
          
          pixels[i*w+j] = pCopy[srcY*w+srcX];
          
          
          //if(srcX>=0 && srcX<w &&
          //   srcY>=0 && srcY<h){
          //  pixels[i*w+j] = pCopy[srcY*w+srcX];     
          //}
          
       }

     }
     return pixels; 
   }
   
   int[] apply(int[] pixels){
     for(int i=0; i<slide2; i++){
        pixels = twirl(twirl(pixels, slide), -slide);
        pb.setValue(floor(((float)i)/((float)slide2)*100));
     }
     frame.setVisible(false);
     return pixels;
       
   }
   
   void slide(){
    if(sl != null){
      slide = sl.getValue();
    } 
   }
   
   void slide2(){
     if(sl2 != null){
      slide2 = sl2.getValue();
    }
   }
    
   int getEnd(){
     return endIndex; 
   }
   
   void clearVals(){
    //stub 
   }
 }
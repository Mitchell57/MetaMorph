/**
 * Twirl implementation
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
 public class Twirl implements Morph {
   Group tg = new Group(cp5, "twirlGroup").setLabel("");
   float twSlide = 0;
   Slider sl;
   int endIndex;
   
   public Twirl(){
     
     cp5.addTextlabel("twLabel1")
        .setPosition(810, 380)
        .setGroup("twirlGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Twirl Amount")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
     
     sl = cp5.addSlider("twSlide")
       .setGroup("twirlGroup")
       .setSize(280, 48)
       .setPosition(810, 400)
       .plugTo(this)
       .setRange(-500, 500)
       .setNumberOfTickMarks(1001)
       .showTickMarks(false)
       .setDefaultValue(0)
       ;
       
     tg.setVisible(false);
     endIndex = 450;
     println("Twirl init");
   }
   
   
   void load(){
     tg.setVisible(true);
   }
   
   void hide(){
     tg.setVisible(false);
   }
   
   int[] apply(int[] pixels){
     int w = img.width;
     int h = img.height;
     
     float cX = (float)w/2.0;
     float cY = (float)h/2.0;
     float maxRadius = sqrt(cX*cX+cY*cY);
     
     float factor = twSlide;
     
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
          
          pb.setValue(floor(((float)i)/((float)h)*100));
          
          //if(srcX>=0 && srcX<w &&
          //   srcY>=0 && srcY<h){
          //  pixels[i*w+j] = pCopy[srcY*w+srcX];     
          //}
          
       }

     }
     frame.setVisible(false);
     return pixels; 
   }
   
   void twSlide(){
     if(sl != null){
      twSlide = sl.getValue();
    }
   }
    
    
   int getEnd(){
     return endIndex; 
   }
   
   
   void clearVals(){
     if(sl != null){
       sl.setValue(0);
     }
   }
  


 }
/**
 * Spherize implementation
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
 public class Spherize implements Morph {
   Group sg = new Group(cp5, "spzGroup").setLabel("");
   float spSlide = 0;
   Slider sl;
   int endIndex;
   PGraphics pg = createGraphics(800, 800);
   
   public Spherize(){
     
     cp5.addTextlabel("spLabel1")
        .setPosition(810, 380)
        .setGroup("spzGroup")
        .setWidth(280)
        .setHeight(40)
        .setText("Spherize Amount")
        .setFont(font)
        .setColor(0)
        .setLineHeight(18)
        ;
     
     sl = cp5.addSlider("spSlide")
       .setGroup("spzGroup")
       .setSize(280, 48)
       .setPosition(810, 400)
       .plugTo(this)
       .setRange(1, 400)
       .setNumberOfTickMarks(1001)
       .showTickMarks(false)
       .setDefaultValue(0)
       ;
       
     sg.setVisible(false);
     endIndex = 450;
     println("Spherize init");
   }
   
   
   void load(){
     sg.setVisible(true);
   }
   
   void hide(){
     sg.setVisible(false);
   }
   
   int[] apply(int[] pixels){
     int w = img.width;
     int h = img.height;
     
     float cX = (float)w/2.0;
     float cY = (float)h/2.0;
     float maxRadius = sqrt(cX*cX+cY*cY);
     
     int[] pCopy = pixels.clone();
     
     float factor = 200;
     
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
          
          if(radius >= spSlide)pixels[i*w+j] = pCopy[srcY*w+srcX];
          
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
   
   void spSlide(){
     if(sl != null){
      
      spSlide = sl.getValue();
      pg.beginDraw();
      pg.noStroke();
      pg.alpha(50);
      pg.fill(255);
      pg.ellipse(400,400, spSlide, spSlide);
      pg.endDraw();
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
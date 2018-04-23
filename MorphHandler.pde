/**
 * Morph handler class
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */

import controlP5.*;



public class MorphHandler {
  Morph[] ma;
  controlP5.Button apply, backButton;
  Morph tw, rp, pt, twk, sp;
  int currMorph;
  
  
  public MorphHandler(){
     apply = cp5.addButton("morph")
       .setSize(240, 28)
       .plugTo(this)
       .setPosition(830, 700)
       .setVisible(false)
       ;
     backButton = cp5.addButton("backButton")
       .setSize(240, 28)
       .plugTo(this)
       .setLabel("Undo")
       .setPosition(830, 730)
       .setVisible(false)
       ;
       
     ma = new Morph[10];
     twk = new Tweak();
     tw = new Twirl();
     rp = new Ripple();
     pt = new Pointillize();
     sp = new Spherize();
     ma[0] = twk;
     ma[1] = tw;
     ma[2] = sp;
     ma[3] = pt;
     ma[4] = rp;
     
     pb.setMinimum(0);
     pb.setMaximum(100);
     pb.setStringPainted(true);
     frame.setLayout(new FlowLayout());
     frame.getContentPane().add(pb);
 
     frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
     frame.setSize(300, 50);
     frame.setLocationRelativeTo(null);
     
      
     
  }
  
  void morph(){
     back = img.get();
     img.loadPixels();
     
     pb.setValue(0);
     frame.setVisible(true);
     
     img.pixels = ma[currMorph].apply(img.pixels);
     img.updatePixels();
     println("Apply Pressed");
  }
  
  void backButton(){
     if(back != null){
       PImage temp = img;
       img = back.get();
       back = temp.get();
       println("Backed up");
     }
  }
  
  
  String[] getMorphs(){
    String [] morphs = {"tweak", "twirl", "spherize", "pointillize", "ripple"};
    return morphs;
  }
  
  void loadMorph(String name){
    ig.hide();
    tw.hide();  
    twk.hide();
    rp.hide();
    pt.hide();
    sp.hide();
    rp.clearVals();
    twk.clearVals();
    tw.clearVals();
    pt.clearVals();
    sp.clearVals();
    switch(name){
      case "tweak":
        twk.load();
        currMorph = 0;
        apply.setPosition(830, min(730, (twk.getEnd()+10)))
          .setVisible(true);
        backButton.setPosition(830, min(730, (twk.getEnd()+50)))
          .setVisible(true);
        println("Chose tweak");
        break;
      case "twirl":
        tw.load();
        currMorph = 1;
        apply.setPosition(830, min(730, (tw.getEnd()+10)))
          .setVisible(true);
        backButton.setPosition(830, min(730, (tw.getEnd()+50)))
          .setVisible(true);
        println("Chose twirl");
        break;
      case "spherize":
        sp.load();
        currMorph = 2;
        apply.setPosition(830, min(730, (sp.getEnd()+10)))
          .setVisible(true);
        backButton.setPosition(830, min(730, (sp.getEnd()+50)))
          .setVisible(true);
        println("Chose Spherize");
        break;
      case "pointillize":
        pt.load();
        currMorph = 3;
        apply.setPosition(830, min(730, (pt.getEnd()+10)))
          .setVisible(true);
        backButton.setPosition(830, min(730, (pt.getEnd()+50)))
          .setVisible(true);
        println("Chose Pointillize");
        break;
      case "ripple":
        rp.load();
        currMorph = 4;
        apply.setPosition(830, min(730, (rp.getEnd()+10)))
          .setVisible(true);
        backButton.setPosition(830, min(730, (rp.getEnd()+50)))
          .setVisible(true);
        println("Chose ripple");
        break;
      
     }
     
  }
  
  void clear(){
    ma[currMorph].clearVals(); 
  }
  
}
  
  
  
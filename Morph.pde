/**
 * Morph interface, Point class, and comparators
 * 
 * work-in-progress
 *
 * by Mitchell Lewis, 2018
 * 
 *
 */
 
  public interface Morph {
   int endIndex = 730;
   void load();
   void hide();
   int[] apply(int[] pixels);
   int getEnd();
   void clearVals();
  }
 
  public class Point{
    int x;
    int y;
    int col;
    
    public Point(int xI, int yI, int colorI){
       x = xI; 
       y = yI;
       col = colorI;
    }
  }
  
  public class SortByBrightA implements Comparator<Point>{
    // Sorts in ascending order of brightness
    public int compare(Point a, Point b){
     return (int)(brightness(a.col) - brightness(b.col));
    }
  }
  
  public class SortByBrightD implements Comparator<Point>{
    // Sorts in ascending order of brightness
    public int compare(Point a, Point b){
     return (int)(brightness(b.col) - brightness(a.col));
    }
  }
  
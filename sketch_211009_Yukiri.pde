PrintWriter output;
final int IMAGES_NUM=3990;//number of images(3990)
final int RATIO=2;//view percent
int i=0;
int r=10;//the radius of circle to display

class IMGset {
  PImage img=null;
  int serial_num=-1;
  boolean check=false;//if you already check this img,true
  int x=0;
  int y=0;
}
IMGset[] imgset=new IMGset[IMAGES_NUM];

class CSVset {//faster than ↑(?)
  int serial_num=-1;
  int x=0;
  int y=0;
}
CSVset[] csvset = new CSVset[IMAGES_NUM+1];
PImage pimage;

void setup() {
  size(540, 960);//the original size (1080,1920) is too large for laptopPC!
  println("Hello world!");
  output=createWriter("positions.csv");
  //Loadimages();//this use about IMAGES_NUM/10 second
  pimage=loadImage(GetImgName(0));
  for(int j=0;j<IMAGES_NUM+1;j++){
    csvset[j]=new CSVset();
  }
  println("length="+csvset.length);
}

void draw() {

  if (i>=IMAGES_NUM+1) {
    println("this is the last image!");
    i=IMAGES_NUM;
  }
  if (i<=-1) {
    println("this is the fast image!");
    i=0;
  }
  
  if (csvset[i].serial_num==-1){//there is no image and date!
    pimage=loadImage(GetImgName(i));
    csvset[i].serial_num=i;    
  }




  //image(imgset[i].img, 0, 0, width, height);
  image(pimage,0,0,width,height);

  if (csvset[i].serial_num!=-1) {
    fill(0, 0, 0);
    ellipse(csvset[i].x, csvset[i].y, r, r);
  }
  fill(0);
  text(GetImgName(i), 50, 50);
}


void keyReleased() {
  
  switch(keyCode) {
  case ENTER://
    PrintCSV();
    break;
  case LEFT:
    println("left!");
    i--;
    break;
  case RIGHT:
    println("right!");
    i++;
    break;
  case UP:
    println("up!");
    i+=10;
    break;
  case DOWN:
    println("down!");
    i-=10;
    break;
  }
  println("i="+i);
  if (i<=0)i=0;
  if (i>IMAGES_NUM)i=IMAGES_NUM;
}


void mouseClicked() {
  ellipse(mouseX, mouseY, r, r);
  if(i>IMAGES_NUM)return;
  csvset[i].x=mouseX;
  csvset[i].y=mouseY;
  //imgset[i].check=true;
  csvset[i].serial_num=i;
  i++;
}

void PrintCSV() {
  println("Fin!");
  for (int j=0; j<IMAGES_NUM+1; j++) {
    if (csvset[j].serial_num==-1) {
      output.close();
      exit();
    }
    output.print(csvset[j].serial_num);
    output.print(",");
    output.print(RATIO*csvset[j].x);
    output.print(",");
    output.print(RATIO*csvset[j].y);
    output.print("\n");
  }
  output.close();
  exit();
}

String GetImgName(int num) {
  String s="";
  if (num<10)s="000";
  else if (num<100)s="00";
  else if (num<1000)s="0";
  s+=num;
  return "tennkuuotosi_"+s+".bmp";
}

void Loadimages() {
  for (int j=0; j<IMAGES_NUM; j++) {
    Loadimage(j);

    if (j==1)println("....1%");
    if (j==  IMAGES_NUM/10)println("...10%");
    if (j==2*IMAGES_NUM/10)println("...20%");
    if (j==3*IMAGES_NUM/10)println("...30%");
    if (j==4*IMAGES_NUM/10)println("...40%");
    if (j==5*IMAGES_NUM/10)println("...50%");
    if (j==6*IMAGES_NUM/10)println("...60%");
    if (j==7*IMAGES_NUM/10)println("...70%");
    if (j==8*IMAGES_NUM/10)println("...80%");
    if (j==9*IMAGES_NUM/10)println("...90%");
    if (j==  IMAGES_NUM-1)   println("..100%");
  }
}
void Loadimage(int n) {
  imgset[n]=new IMGset();
  imgset[n].serial_num=1;
  imgset[n].img=loadImage(GetImgName(n));
}

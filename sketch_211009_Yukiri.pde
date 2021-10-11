PrintWriter output;
final int IMAGES_NUM=111;//number of images
final int RATIO=2;//view percent
int i=0;
int r=10;//the radius of circle to display

class IMGset {
  PImage img;
  int serial_num=-1;
  boolean check=false;//if you already check this img,true
  int x=0;
  int y=0;
}
IMGset[] imgset=new IMGset[IMAGES_NUM];

void setup() {
  size(540, 960);//the original size (1080,1920) is too large for laptopPC!
  println("Hello world!");
  output=createWriter("positions.csv");
  Loadimages();//this use about IMAGES_NUM/10 second
}

void draw() {

  if (i>=IMAGES_NUM) {
    println("this is the last image!");
    i=IMAGES_NUM-1;
  }
  if(i<=0){
    println("this is the fast image!");
    i=0;
  }

  image(imgset[i].img, 0, 0, width, height);

  if (imgset[i].check) {
    fill(0, 0, 0);
    ellipse(imgset[i].x, imgset[i].y, r, r);
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
  if (i>=IMAGES_NUM)i=IMAGES_NUM-1;
}


void mouseClicked() {
  ellipse(mouseX, mouseY, r, r);
  imgset[i].x=mouseX;
  imgset[i].y=mouseY;
  imgset[i].check=true;
  imgset[i].serial_num=i;
  i++;
}

void PrintCSV() {
  println("Fin!");
  for (int j=0; j<IMAGES_NUM; j++) {
    if (!imgset[j].check) {
      output.close();
      exit();
    }
    output.print(imgset[j].serial_num);
    output.print(",");
    output.print(RATIO*imgset[j].x);
    output.print(",");
    output.print(RATIO*imgset[j].y);
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
    imgset[j]=new IMGset();
    imgset[j].serial_num=1;
    imgset[j].img=loadImage(GetImgName(j));//load OK;
    //println(GetImgName(j));
    if(j==1)println("....1%");
    if(j==  IMAGES_NUM/10)println("...10%");
    if(j==2*IMAGES_NUM/10)println("...20%");
    if(j==3*IMAGES_NUM/10)println("...30%");
    if(j==4*IMAGES_NUM/10)println("...40%");
    if(j==5*IMAGES_NUM/10)println("...50%");
    if(j==6*IMAGES_NUM/10)println("...60%");
    if(j==7*IMAGES_NUM/10)println("...70%");
    if(j==8*IMAGES_NUM/10)println("...80%");
    if(j==9*IMAGES_NUM/10)println("...90%");
    if(j==  IMAGES_NUM-1)   println("..100%");
    
  }
}

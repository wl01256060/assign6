class Bullet{
	int x = 0;
	int y = 0;
    PImage bulletImg;

	Bullet(int x, int y) {
		this.x = x;
		this.y = y;
              bulletImg = loadImage("img/shoot.png");
                             for (int i = 0; i < 5; ++i) {
                            bulletNumLimit[i] = false;
                           }
	}
void move(){
   this.x -= 5;
}

void draw(){
  for(int i = 0; i<5; i++){
    if(bulletNumLimit[i] ==true){
      image(bulletImg,x,y);
    }
    if(x<0){
      bulletNumLimit[i] = false;
    }
  }
}
boolean isOutOfBorder()
  {
        if(x>width){
          return true;
        }else{
          return false;
        }
  }

}

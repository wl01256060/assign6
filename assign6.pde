class GameState
{
	static final int START = 0;
	static final int PLAYING = 1;
	static final int END = 2;
}
class Direction
{
	static final int LEFT = 0;
	static final int RIGHT = 1;
	static final int UP = 2;
	static final int DOWN = 3;
}
class EnemysShowingType
{
	static final int STRAIGHT = 0;
	static final int SLOPE = 1;
	static final int DIAMOND = 2;
	static final int STRONGLINE = 3;
}
class FlightType
{
	static final int FIGHTER = 0;
	static final int ENEMY = 1;
	static final int ENEMYSTRONG = 2;
}

int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
Enemy[] enemys = new Enemy[enemyCount];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPDisplay hpDisplay;
Bullet[] bullet = new Bullet[5];

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 4000;
int bulletNum = 0;
boolean []bulletNumLimit = new boolean [5];
int bNum = 0;
int eNum = 0;


void setup () {
	size(640, 480);
	flameMgr = new FlameMgr();
	bg = new Background();
	treasure = new Treasure();
	hpDisplay = new HPDisplay();
	fighter = new Fighter(20);
for(int i = 0; i<5; i++){
  bullet[i] = new Bullet(fighter.x,fighter.y);
}
}

void draw()
{
	if (state == GameState.START) {
		bg.draw();	
	}
	else if (state == GameState.PLAYING) {
		bg.draw();
		treasure.draw();
		flameMgr.draw();
		fighter.draw();

		//enemys
		if(millis() - time >= wait){
			addEnemy(currentType++);
			currentType = currentType%4;
		}		

		for (int i = 0; i < enemyCount; ++i) {
			if (enemys[i]!= null) {
				enemys[i].move();
				enemys[i].draw();
				if (enemys[i].isCollideWithFighter()) {
					fighter.hpValueChange(-20);
					flameMgr.addFlame(enemys[i].x, enemys[i].y);
					enemys[i]=null;
				}
				else if (enemys[i].isOutOfBorder()) {
					enemys[i]=null;
				}
			}
		}
		// 這地方應該加入Fighter 血量顯示UI
		 hpDisplay.updateWithFighterHP(fighter.hp);
	}
	else if (state == GameState.END) {
		bg.draw();
	}
//bullet
for (int i = 0; i < 5; i ++){
  if(bulletNumLimit[i] == true){
        bullet[i].draw();
        bullet[i].move();
      }
      if(bullet[i].x<0){
        bulletNumLimit[i] = false;
      }
  }

for(int j = 0; j < enemyCount; j++){
for (int i = 0; i < 5; i ++){
    if(enemys[j] != null){
    if(bulletNumLimit[i] == true){
      if(isHit(bullet[i].x, bullet[i].y, 31, 27, enemys[j].x, enemys[j].y, 61, 61)){
          flameMgr.addFlame(enemys[j].x, enemys[j].y);
          bulletNumLimit[i] = false;
          enemys[j] = null;
      }else if(bullet[i].isOutOfBorder()){
        bulletNumLimit[i] = false;
      }
      }
      }
  }
    }
  }
boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
	// Collision x-axis?
    boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
    // Collision y-axis?
    boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
    return collisionX && collisionY;
}

void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased(){
  switch(keyCode){
	case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') {
  	if (state == GameState.PLAYING) {
		fighter.shoot();
	}
  }
  if (key == ENTER) {
    switch(state) {
      case GameState.START:
      case GameState.END:
        state = GameState.PLAYING;
		enemys = new Enemy[enemyCount];
		flameMgr = new FlameMgr();
		treasure = new Treasure();
		fighter = new Fighter(20);
      default : break ;
    }
  }
}

class Fighter{
	PImage fighterImg;
	int x = 0;
	int y = 0;
	int type;
	int speed = 5;

	int hp;
	Fighter(int hp) {
		this.fighterImg = loadImage("img/fighter.png");
		this.x = width - this.fighterImg.width;
		this.y = (height-this.fighterImg.height)/2;
		this.type = FlightType.FIGHTER;
		this.hp = hp;
	}

	void draw() {
		image(fighterImg, this.x, this.y);

		if (isMovingUp) {
			this.move(Direction.UP);
		}
		if (isMovingDown) {
			this.move(Direction.DOWN);	
		}
		if (isMovingLeft) {
			this.move(Direction.LEFT);
		}
		if (isMovingRight) {
			this.move(Direction.RIGHT);	
		}
	}

	void shoot() {
  if ( bulletNum > 4 ) {
        bulletNum = 0;
      }
  	if (bulletNumLimit[bulletNum] == false){
        bulletNumLimit[bulletNum] = true;
       bullet[bulletNum].x = fighter.x;
       bullet[bulletNum].y  = fighter.y;
        bulletNum ++;
      }

      
	}

	void move(int direct) {
		switch (direct) {
			case Direction.UP:
				if (this.y - speed > 0) {
					this.y-= speed;
				}
				break;
			case Direction.DOWN:
				if (this.y + speed < height - this.fighterImg.height) {
					this.y+= speed;
				}
				break;
			case Direction.LEFT:
				if (this.x - speed > 0) {
					this.x-= speed;
				}
				break;
			case Direction.RIGHT:
				if (this.x + speed < width - this.fighterImg.width) {
					this.x+= speed;
				}
				break;
		}
	}

	void hpValueChange(int value)
	{
		this.hp += value;
		if (this.hp <=0) {
			state = GameState.END;
			return;
		}
		else if (this.hp >= 100) {
			this.hp = 100;
			return;
		}
		return;
	}
}

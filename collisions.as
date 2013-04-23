package{
	
	public class collisions{
		
		private var Tile_size:int;			
		private var level;					
		private var nextPlayerPos_x:int;			
		private var nextPlayerPos_y:int;			
		public var can_jump:Boolean;		
		private var player;					
		
		public function calcGround(){
			
			player.downy = Math.round((player.y + 11 - Tile_size/2) / Tile_size);
			player.rightx = Math.round((player.x + 5 - Tile_size/2) / Tile_size)
			player.leftx = Math.round((player.x - 5 - Tile_size/2) / Tile_size);
			
			
			player.downleft = level[player.downy][player.leftx];
			player.downright = level[player.downy][player.rightx];
			
			
			if(player.downleft == 1 || player.downright == 1){		
				can_jump = true;								
			}
			else{
				can_jump = false;								
			}
		}
		
		public function Setup(size, map, tempPlayer){		
			Tile_size = size;						
			level = map;
			player = tempPlayer;
		}
		
		public function getCorners(point_x,point_y){				
		//get the position of the four corners of the player
			
			player.downy = Math.round((point_y + 10 - Tile_size/2) / Tile_size);
			player.upy = Math.round((point_y - 10 - Tile_size/2) / Tile_size);
			player.rightx = Math.round((point_x + 5 - Tile_size/2) / Tile_size)
			player.leftx = Math.round((point_x - 5 - Tile_size/2) / Tile_size);
			
			player.downleft = level[player.downy][player.leftx];
			player.downright = level[player.downy][player.rightx];
			player.upright = level[player.upy][player.rightx];
			player.upleft = level[player.upy][player.leftx];
			
		}
		
		public function collisionLoop(nextPlayerPosx, nextPlayerPosy){
		
			nextPlayerPos_x = nextPlayerPosx;
			nextPlayerPos_y = nextPlayerPosy;
			
			getCorners(nextPlayerPos_x,nextPlayerPos_y);
			
			if(player.downleft == 1){
				getCorners(player.x,nextPlayerPos_y);
					if(player.downleft == 1){					
						player.downE = true;
					}
					else{
						player.downE = false;
					}
				getCorners(nextPlayerPos_x,player.y);
					if(player.downleft == 1){					
						player.leftE = true;
					}
					else{
						player.leftE = false;
					}
					if(player.leftE && player.downE){
						nextPlayerPos_x = (player.leftx+1) * 25 + 5;
						nextPlayerPos_y = (player.downy+1) * 25 - 11;
						player.y_speed = 0;
					}
					else if(player.leftE){
						nextPlayerPos_x = (player.leftx+1) * 25 + 5;
					}
					else if(player.downE){
						nextPlayerPos_y = (player.downy+1) * 25 - 11;
						player.y_speed = 0;
					}
			}
			
			getCorners(nextPlayerPos_x,nextPlayerPos_y);
			
			if(player.downright == 1){
				getCorners(player.x,nextPlayerPos_y);
					if(player.downright == 1){					
						player.downE = true;
					}
					else{
						player.downE = false;
					}
				getCorners(nextPlayerPos_x,player.y);
					if(player.downright == 1){					
						player.rightE = true;
					}
					else{
						player.rightE = false;
					}
					if(player.rightE && player.downE){
						nextPlayerPos_x = player.rightx * 25 - 6;
						nextPlayerPos_y = (player.downy+1) * 25 - 11;
						player.y_speed = 0;
					}
					else if(player.rightE){
						nextPlayerPos_x = player.rightx * 25 - 6;
					}
					else if(player.downE){
						nextPlayerPos_y = (player.downy+1) * 25 - 11;
						player.y_speed = 0;
					}
			}
			
			getCorners(nextPlayerPos_x,nextPlayerPos_y);
			
			if(player.upleft == 1){
				getCorners(player.x,nextPlayerPos_y);
					if(player.upleft == 1){					
						player.upE = true;
					}
					else{
						player.upE = false;
					}
				getCorners(nextPlayerPos_x,player.y);
					if(player.upleft == 1){					
						player.leftE = true;
					}
					else{
						player.leftE = false;
					}
					if(player.leftE && player.upE){
						nextPlayerPos_x = (player.leftx+1) * 25 + 5;
						nextPlayerPos_y = (player.upy) * 25 + 10;
						player.y_speed = 0;
					}
					else if(player.leftE){
						nextPlayerPos_x = (player.leftx+1) * 25 + 5;
					}
					else if(player.upE){
						nextPlayerPos_y = (player.upy) * 25 + 10;
						player.y_speed  = 0;
					}
			}
			
			getCorners(nextPlayerPos_x,nextPlayerPos_y);
			
			if(player.upright == 1){
				getCorners(player.x,nextPlayerPos_y);
					if(player.upright == 1){					
						player.upE = true;
					}
					else{
						player.upE = false;
					}
				getCorners(nextPlayerPos_x,player.y);
					if(player.upright == 1){					
						player.leftE = true;
					}
					else{
						player.leftE = false;
					}
					if(player.leftE && player.upE){
						nextPlayerPos_x = player.rightx * 25 - 6;
						nextPlayerPos_y = (player.upy) * 25 + 10;
						player.y_speed = 0;
					}
					else if(player.leftE){
						nextPlayerPos_x = player.rightx * 25 - 6;
					}
					else if(player.upE){
						nextPlayerPos_y = (player.upy) * 25 + 10;
						player.y_speed  = 0;
					}
			}
			
			player.x = nextPlayerPos_x;		
			player.y = nextPlayerPos_y;
			
			calcGround()		
		}
	}
}
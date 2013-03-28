package{
	
	public class collision_manager{
		private var Tile_size:int;			//containing the size of the tiles
		private var level;					//level data container
		private var forecast_x:int;			//where the player will be at the end of the frame
		private var forecast_y:int;			//"												  "
		public var can_jump:Boolean;		//same as in Emanuele's tutorial
		private var hero;					//to store the Hero object in
		
		public function Setup(size,map,heroj){		//my standard setup function(init)
			Tile_size = size;						//initializing al vars
			level = map;
			hero = heroj;
		}
		
		public function get_corners(point_x,point_y){				
		//get the position of the four corners of the hero
			
			hero.downy = Math.round((point_y + 10 - Tile_size/2) / Tile_size);
			hero.upy = Math.round((point_y - 10 - Tile_size/2) / Tile_size);
			hero.rightx = Math.round((point_x + 5 - Tile_size/2) / Tile_size)
			hero.leftx = Math.round((point_x - 5 - Tile_size/2) / Tile_size);
			/*
			Looks in wich tiles these four point are.
			*Attention* TILES and not pixel!
			
			Will be used to get the position of the corners 
			and to get the end position of the hero.
			*/
			
			hero.downleft = level[hero.downy][hero.leftx];
			hero.downright = level[hero.downy][hero.rightx];
			hero.upright = level[hero.upy][hero.rightx];
			hero.upleft = level[hero.upy][hero.leftx];
			
			
			/*
			Gets the sort tile the position of the corners has.
			
			One means there can be collision, zero is air.			
			*/
		}
		
		public function check_ground(){
			hero.downy = Math.round((hero.y + 11 - Tile_size/2) / Tile_size);
			hero.rightx = Math.round((hero.x + 5 - Tile_size/2) / Tile_size)
			hero.leftx = Math.round((hero.x - 5 - Tile_size/2) / Tile_size);
			// Makes three points in tile-coordinates
			
			hero.downleft = level[hero.downy][hero.leftx];
			hero.downright = level[hero.downy][hero.rightx];
			//Checks the sort
			
			if(hero.downleft == 1 || hero.downright ==1){		//if there is any collision by the hero's feet
				can_jump = true;								//than can jump
			}
			else{
				can_jump = false;								//else not
			}
		}
		
		public function solve_all(forecastx, forecasty){
		/*
		This function looks hard... an it is...
		I've been working on it for loads of hours, and this is the result.
		
		This is the best collision-test I've ever made, for sqaures.
		
		It's still readable, because I made it simple.
		
		It's four times almost the same. It checks for collision between the spots, 
		the four spots if there only were x_speeds, the four spots if there only was y_speed, 
		the four spots if there were both y- and x_speed.	
		That are 3*4 = 12 spots.
		
		
		//////////////////////////////////
		Why's:
		
		question:
		Why did I used forecast_x and forecast_y and not just hero.x and hero.y?
		
		answer:
		Changing the hero over the screen will cost loads of CPU because an hero 
		exist out of loads of pixels. The forecast's are just simple variables
		
		question:
		Is such a huge function not requiring a lot of CPU?
		
		answer:
		It doesn't uses any while- or for loops, Math. functions and the most important of 
		all: no hitTestPoint()/hitTestObject(). So it's a lot faster.
		
		question:
		Is there a better or faster collision test?
		
		answer:
		Probaly, yes.
		//////////////////////////////////
		
		var-explanation:
		
		downC 	-> 	is collision under the spot
		upC		->	is collision above the spot
		rightC	->	is collision right from the spot
		leftC	->	You probaly wouldn't expect this, but this is collision left from the spot
		
				*/
			forecast_x = forecastx;
			forecast_y = forecasty;
			
			get_corners(forecast_x,forecast_y);
			
			if(hero.downleft == 1){
				get_corners(hero.x,forecast_y);
					if(hero.downleft == 1){					
						hero.downC = true;
					}
					else{
						hero.downC = false;
					}
				get_corners(forecast_x,hero.y);
					if(hero.downleft == 1){					
						hero.leftC = true;
					}
					else{
						hero.leftC = false;
					}
					if(hero.leftC && hero.downC){
						forecast_x = (hero.leftx+1) * 25 + 5;
						forecast_y = (hero.downy+1) * 25 - 11;
						hero.y_speed = 0;
					}
					else if(hero.leftC){
						forecast_x = (hero.leftx+1) * 25 + 5;
					}
					else if(hero.downC){
						forecast_y = (hero.downy+1) * 25 - 11;
						hero.y_speed = 0;
					}
			}
			
			get_corners(forecast_x,forecast_y);
			
			if(hero.downright == 1){
				get_corners(hero.x,forecast_y);
					if(hero.downright == 1){					
						hero.downC = true;
					}
					else{
						hero.downC = false;
					}
				get_corners(forecast_x,hero.y);
					if(hero.downright == 1){					
						hero.rightC = true;
					}
					else{
						hero.rightC = false;
					}
					if(hero.rightC && hero.downC){
						forecast_x = hero.rightx * 25 - 6;
						forecast_y = (hero.downy+1) * 25 - 11;
						hero.y_speed = 0;
					}
					else if(hero.rightC){
						forecast_x = hero.rightx * 25 - 6;
					}
					else if(hero.downC){
						forecast_y = (hero.downy+1) * 25 - 11;
						hero.y_speed = 0;
					}
			}
			
			get_corners(forecast_x,forecast_y);
			
			if(hero.upleft == 1){
				get_corners(hero.x,forecast_y);
					if(hero.upleft == 1){					
						hero.upC = true;
					}
					else{
						hero.upC = false;
					}
				get_corners(forecast_x,hero.y);
					if(hero.upleft == 1){					
						hero.leftC = true;
					}
					else{
						hero.leftC = false;
					}
					if(hero.leftC && hero.upC){
						forecast_x = (hero.leftx+1) * 25 + 5;
						forecast_y = (hero.upy) * 25 + 10;
						hero.y_speed = 0;
					}
					else if(hero.leftC){
						forecast_x = (hero.leftx+1) * 25 + 5;
					}
					else if(hero.upC){
						forecast_y = (hero.upy) * 25 + 10;
						hero.y_speed  = 0;
					}
			}
			
			get_corners(forecast_x,forecast_y);
			
			if(hero.upright == 1){
				get_corners(hero.x,forecast_y);
					if(hero.upright == 1){					
						hero.upC = true;
					}
					else{
						hero.upC = false;
					}
				get_corners(forecast_x,hero.y);
					if(hero.upright == 1){					
						hero.leftC = true;
					}
					else{
						hero.leftC = false;
					}
					if(hero.leftC && hero.upC){
						forecast_x = hero.rightx * 25 - 6;
						forecast_y = (hero.upy) * 25 + 10;
						hero.y_speed = 0;
					}
					else if(hero.leftC){
						forecast_x = hero.rightx * 25 - 6;
					}
					else if(hero.upC){
						forecast_y = (hero.upy) * 25 + 10;
						hero.y_speed  = 0;
					}
			}
			
			hero.x = forecast_x;		//place the hero
			hero.y = forecast_y;
			
			check_ground()		//runs the function to check for ground
		}
	}
}

// You may not post this on any other site than: http://www.emanueleferonato.com or http://www.frozenhaddock.com. You may not claim that you wrote this code. I'm not responsible for any nuclear activity that may be caused by this script.
/*____________________________________________________
|______________	register of functions _______________|
|____________________________________________________|

- main()			only calling to update_hero() (every frame)

- create_hero()		creates hero as the var "Hero"

- update_hero()		check collision an move

- BuildMap()		load and create the level


extern

Data.as
- Setup()			create levels 

collision_manager.as
- Setup(size,map,hero)		setup the map

- Solve_all(forecastx,forecasty)		solves the collsions and checks for a jump
*/


package{												//The begin of an .as file
	import flash.display.MovieClip;						//import some libraries
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class Script extends MovieClip{				// start the script
	
	private const gravity:int = 1;
	private const max_speed:int = 8;
	
	private const walkspeed:int = 4;
	private const jumpspeed:int = 10;
	
	private var forecast_x:int;
	private var forecast_y:int;
	
	private const start_x:int = 50;
	private const start_y:int = 50;
	
	private var left:Boolean;
	private var up:Boolean;
	private var right:Boolean;
	private var space:Boolean;
		
	private var level:Array = new Array();
	private var tiles:Array = new Array();
	
	private var Map_data:Data = new Data;				// create a version of the Data.as
	private var Hero_col:collision_manager = new collision_manager;
	
	private var Hero:BlackCat = new BlackCat;
	
		public function Script(){						// the init (will only be runned once)
			BuildMap();
			create_hero();
			addEventListener(Event.ENTER_FRAME, main);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
			
			Hero_col.Setup(25,level,Hero);
		}
		
		private function main(event:Event){
			update_hero();
		}
		
		private function key_down(event:KeyboardEvent){
			if(event.keyCode == 37){
				left = true;
			}
			if(event.keyCode == 38){
				up = true;
			}
			if(event.keyCode == 39){
				right = true;
			}
		}
		
		private function key_up(event:KeyboardEvent){
			if(event.keyCode == 37){
				left = false;
			}
			if(event.keyCode == 38){
				up = false;
			}
			if(event.keyCode == 39){
				right = false;
			}
		}
								
			
		
/*
///    ///		/////////	///////////		///////////
///    ///		///			////    ///		///		///
///    ///		///			////    ///		///		///
//////////		/////////	//////////		///		///
//////////		/////////	////	///		///		///
///    ///		///			////	///		///		///
///    ///		///			////	///		///		///
///    ///		/////////	////	///		///////////
*/
		private function create_hero(){
			addChild(Hero);
			Hero.scaleX = 0.25;
			Hero.scaleY = 0.25;
			Hero.x = start_x;
			Hero.y = start_y;
			Hero.x_speed = 0;
			Hero.y_speed = 0;
		}
		
		private function update_hero(){
			Hero.y_speed += gravity;
			if(left){
				Hero.x_speed = -walkspeed;
				if(Hero.scaleX > 0)
					Hero.scaleX = -Hero.scaleX;
				Hero.play();
			}
			if(right){
				Hero.x_speed = walkspeed;
				if(Hero.scaleX < 0)
					Hero.scaleX = -Hero.scaleX;
				Hero.play();
			}
			if(up && Hero_col.can_jump){
				Hero.y_speed = -jumpspeed;
			}
			
			if(Hero.y_speed > max_speed){
				Hero.y_speed = max_speed;
			}
			
			forecast_y = Hero.y + Hero.y_speed;
			forecast_x = Hero.x + Hero.x_speed;
			
			Hero_col.solve_all(forecast_x, forecast_y);
			
			
			Hero.x_speed = 0;
			if(!left && !right)
				Hero.stop();
		}
	
	
/*
|||||||||||		 |||||||||||	  ||||||||||	||||||||||
||||||||||||	||||||||||||	 ||||	 ||||	||||	|||
||||	||||| |||||		||||	 ||||||||||||	||||||||||
||||	  |||||||		||||	 ||||	 ||||	||||
||||	    |||			||||	||||	  ||||	||||
||||					||||	||||      ||||	||||
*/
				
		private function BuildMap(){
			Map_data.Setup();												// setup data from extern file
			
			level = Map_data.level1;										// get data from extern file
			
			for(var t = 0; t < level.length; t++){
				for(var u = 0; u < level[t].length; u++){
					if(level[t][u] != 0){									//if the data is not null
						var new_tile:platform_tile = new platform_tile;		//than build a tile
						
						addChild(new_tile);									//put it on the screen
						
						new_tile.gotoAndStop(1);
						new_tile.x = u * 25;
						new_tile.y = t * 25;
						
						tiles.push(new_tile);								//put it in an array
					}
				}
			}
		}
	}
}

// You may not post this on any other site than: http://www.emanueleferonato.com or http://www.frozenhaddock.com. You may not claim that you wrote this code. I'm not responsible for any nuclear activity that may be caused by this script.
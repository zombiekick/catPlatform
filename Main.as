package{												
	import flash.display.MovieClip;						
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.display.DisplayObject;

	public class Main extends MovieClip{				
	
	private const gravity:int = 1;
	private const max_speed:int = 8;
	
	private const walkspeed:int = 4;
	private const jumpspeed:int = 10;
	
	private var nextPlayerPos_x:int;
	private var nextPlayerPos_y:int;
	
	private const start_x:int = 50;
	private const start_y:int = 50;
	
	private var currentMap:int = 1;
	
	private var left:Boolean;
	private var up:Boolean;
	private var right:Boolean;
	private var space:Boolean;
		
	private var level:Array = new Array();
	private var tiles:Array = new Array();
	private var winTiles:Array = new Array();
	private var coins:Array = new Array();
	
	private var Map_data:Map = new Map();	
	private var player_col:collisions = new collisions();
	
	private var player:BlackCat = new BlackCat();
	
		public function Main(){						
			BuildMap(1);
			createPlayer();
			addEventListener(Event.ENTER_FRAME, main);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
			
			player_col.Setup(25,level,player);
		}
		
		private function main(event:Event){
			updatePlayer();
		}
		
		private function checkCollision($obj1:DisplayObject, $obj2:DisplayObject):Boolean 
		{
			//check for collision between 2 display objects
			if(!$obj1.root || !$obj2.root || !$obj1.hitTestObject($obj2))
			    return false;
			else
				return true;
		}
		
		private function checkCoin()
		{
			for(var c:int = 0; c < coins.length; c++)
			{
				if(checkCollision(player, coins[c]))
				{
					trace("removed coin");
					coins[c].visible = false;
					coins.splice(c, 1);
				}
			}
		}
		private function checkGoal()
		{
			for(var i:int = 0; i < winTiles.length; i++)
			{
				
				if(coins.length == 0){
					if(checkCollision(player, winTiles[i]))
					{
						trace("next level");
						currentMap++;
						
						for(var j:int = 0; j < tiles.length; i++)
						{
							this.removeChild(tiles[j]);
							tiles.splice(j, 1);							
						}
						
						BuildMap(currentMap);
						return;
					}
				}
			}
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
								
		private function createPlayer(){
			addChild(player);
			player.scaleX = 0.25;
			player.scaleY = 0.25;
			player.x = start_x;
			player.y = start_y;
			player.x_speed = 0;
			player.y_speed = 0;
		}
		
		private function updatePlayer(){
			
						
			player.y_speed += gravity;
			if(left){
				player.x_speed = -walkspeed;
				if(player.scaleX > 0)
					player.scaleX = -player.scaleX;
				player.play();
			}
			if(right){
				player.x_speed = walkspeed;
				if(player.scaleX < 0)
					player.scaleX = -player.scaleX;
				player.play();
			}
			if(up && player_col.can_jump){
				player.y_speed = -jumpspeed;
			}
			
			if(player.y_speed > max_speed){
				player.y_speed = max_speed;
			}
			
			nextPlayerPos_y = player.y + player.y_speed;
			nextPlayerPos_x = player.x + player.x_speed;
			
			player_col.collisionLoop(nextPlayerPos_x, nextPlayerPos_y);
			
				
			//if the player has gotten to the goal, load the next level
			checkGoal();
			checkCoin();
			player.x_speed = 0;
			if(!left && !right)
				player.stop();
		}
				
		private function BuildMap(levelToLoad:int){			
			
			Map_data.SetupLevels();
			
			switch(levelToLoad)
			{
				case 1:
				level = Map_data.level1			
				break
				case 2:
				level = Map_data.level2;	
				break
				case 3:
				level = Map_data.level3;
				break
				case 4:
				level = Map_data.level4;
				break;
				case 5:
				level = Map_data.level5;
				break;
				case 6:
				level = Map_data.level6;
				break;
			}
			
			for(var t = 0; t < level.length; t++){
				for(var u = 0; u < level[t].length; u++){
					
					if(level[t][u] == 1){									
						var new_tile:platform_tile = new platform_tile();		
						
						addChild(new_tile);									
						
						new_tile.gotoAndStop(1);
						new_tile.x = u * 25;
						new_tile.y = t * 25;
						
						tiles.push(new_tile);								
					}
					
					if(level[t][u] == 2)
					{
						var new_winTile:win_tile = new win_tile();		
						
						addChild(new_winTile);									
						
						new_winTile.gotoAndStop(1);
						new_winTile.x = u * 25;
						new_winTile.y = t * 25;
						
						winTiles.push(new_winTile);
						tiles.push(new_winTile);
					}
					
					if(level[t][u] == 3)
					{
						var new_coin:Coin = new Coin();		
						
						addChild(new_coin);									
						
						new_coin.gotoAndStop(1);
						new_coin.x = u * 25;
						new_coin.y = t * 25;
						
						coins.push(new_coin);
						tiles.push(new_coin);
					}
					
				}
			}
			
			player_col.Setup(25,level,player);
		}
		
	}
	
}
package Code
{
	import Code.Maths.Vector2;
	import Code.System.*;
	import Code.Maths.*;
	import Code.Characters.*;
	import Code.Graphics.*;
	import flash.display.*;
	import Code.Geometry.AABB;
	import Code.Level.*;
	import Code.Physics.*;
	
	[SWF(width="640", height="360", backgroundColor="#000000")]
	public class Platformer extends GameLoop
	{
		private const kMaxCharacters:int = 50;
		
		private var m_map:Map;
		
		// fast allocator for vector2s, cleared once per frame
		static public var m_gTempVectorPool:VectorPool;
		
		private var m_keyboard:Keyboard;
		private var m_player:Player;
		private var m_camera:Camera;
		
		private var m_dynamicGfx:Vector.<Sprite>;
		
		
		/// <summary>
		/// 
		/// </summary>	
		public function Platformer( )
		{
			super( );
						 
			// keyboard controller
			m_keyboard = new Keyboard( this.stage );
			
			// temporary vector2 pool for fast allocation
			m_gTempVectorPool = new VectorPool( 10000 );
			
			m_dynamicGfx = new Vector.<Sprite>( );
			
			// create the single map and all the tiles which go with it
			m_map = new SimpleMap(this);
			CreateTilesInner( m_map.m_Map );
			
			// camera controls what we see
			m_camera = new Camera( this, m_player );
			
			// set 30 fps
			this.stage.frameRate = Constants.kDesiredFps;
			
			// start the update loop
			Start( );
		}
		
		/// <summary>
		/// Acessor for the keyboard
		/// </summary>
		public function get m_Keyboard( ):Keyboard
		{
			return m_keyboard;
		}
		
		/// <summary>
		/// Acessor for the player
		/// </summary>
		public function get m_Player( ):Player
		{
			return m_player;
		}
		
		/// <summary>
		/// Create all the tiles in the game
		/// </summary>	
		private function CreateTilesInner( tileSet:Vector.<uint>, addtoScene:Boolean=true ):void
		{
			var index:int = 0;
			for each ( var tileCode:uint in tileSet )
			{
				var tile:MovieClip;
				
				// calculate the position of each tile: 0,0 maps to Constants.kWorldHalfExtents
				var tileI:int = index%m_map.m_Width;
				var tileJ:int = index/m_map.m_Width;
				
				var tileX:int = Map.TileCoordsToWorldX(tileI);
				var tileY:int = Map.TileCoordsToWorldY(tileJ);
				
				var tilePos:Vector2 = new Vector2( tileX, tileY );
				
				// create each tile
				switch ( tileCode )
				{
					//
					// foreground tiles
					//
					
					case eTileTypes.kEmpty:							tile = null;									break;
					case eTileTypes.kPlatform:
					{
						tile = new MovieClip( );
						tile.graphics.beginFill( 0xffffff );
						tile.graphics.drawRect( 0, 0, Constants.kTileSize, Constants.kTileSize );
						tile.graphics.endFill( );
					}
					break;
					
					
					
					//
					// characters
					//
					
					case eTileTypes.kPlayer:
					{
						tile = m_player = Player(SpawnMo( PlayerFla, tilePos ));
						tilePos = m_player.m_Pos;
					}
					break;
					
					
					default: Assert( false, "Unexpected tile code " + tileCode );
				}
				
				if ( tile!=null )
				{
					tile.x = tilePos.m_x;
					tile.y = tilePos.m_y;
					tile.cacheAsBitmap = true;
					
					if ( addtoScene )
					{
						this.addChild( tile );
					}
				}
				
				index++;
			}
		}
		
		/// <summary>
		/// 
		/// </summary>	
		protected override function Update( dt:Number ):void
		{
			if ( dt>0 )
			{
				// fixed frame rate
				dt = 1.0/30.0;
				
				m_keyboard.Update( );
				
				ClearDynamicGfx( );
				
				// update all moveable objects
				m_player.Update( dt );
				
				// camera depends on player
				m_camera.Update( dt );
				
				// clear vector2 allocator
				m_gTempVectorPool.Clear( );
			}
		}
		
		/// <summary>
		/// Debug function
		/// </summary>	
		public function DrawPoint( p:Vector2, colour:uint, radius:Number=2 ):void
		{
			var spr:Sprite = new Sprite( );
			
			spr.graphics.beginFill( colour );
			spr.graphics.drawCircle( 0, 0, radius );
			spr.graphics.endFill( );
			
			spr.x = p.m_x;
			spr.y = p.m_y;
			
			m_dynamicGfx.push( spr );
			this.addChild( spr );
		}
		
		/// <summary>
		/// Debug function
		/// </summary>	
		private function ClearDynamicGfx( ):void
		{
			for each(var s:Sprite in m_dynamicGfx)
			{
				this.removeChild( s );
			}
			
			m_dynamicGfx = new Vector.<Sprite>( );
		}
		
		/// <summary>
		/// Spawn a MoveableObject of the given type at the given location
		/// </summary>
		public function SpawnMo( type:Class, pos:Vector2, addToScene:Boolean=false, ...args ):MoveableObject
		{
			var instance:* = new type();							
			instance.Initialise( pos, m_map, this, args );
			
			if ( addToScene )
			{
				this.addChild( instance );
			}
			
			return instance;
		}
	}
}

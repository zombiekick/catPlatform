package Code.Level
{
	import Code.*;
	import Code.Maths.*;
	
	public class SimpleMap extends Map
	{
		private const kMapWidth:int = 10;
		private const kMapHeight:int = 15;
		
		// map for the level
		private var m_map:Vector.<uint> = Vector.<uint>
		( 
			[
				1,1,1,1,1,1,1,1,1,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,0,1,1,1,1,0,0,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,1,1,0,0,1,1,0,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,0,1,1,1,0,0,0,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,1,0,0,0,1,1,0,1,
				1,0,0,0,0,0,0,0,0,1,
				1,0,0,1,1,1,0,0,0,1,
				1,0,0,0,0,0,0,1,1,1,
				1,2,0,0,0,0,0,0,0,1,
				1,1,1,1,1,1,1,1,1,1
			]
		);
		
		public function SimpleMap( platformer:Platformer )
		{
			super( platformer );
			
			// fill this in
			Constants.kWorldHalfExtents = new Vector2( m_Width*Constants.kTileSize*0.5, m_Height*Constants.kTileSize*0.5 );
		}
		
		/// <summary>
		/// 
		/// </summary>
		public override function get m_Width( ):int
		{
			return kMapWidth;
		}
		
		/// <summary>
		/// 
		/// </summary>
		public override function get m_Height( ):int
		{
			return kMapHeight;
		}
		
		/// <summary>
		/// 
		/// </summary>
		public override function get m_Map( ):Vector.<uint>
		{
			return m_map;
		}
	}
}

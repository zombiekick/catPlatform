package Code.Characters
{
	import flash.display.*;
	import Code.Constants;
	
	public class PlayerFla extends Player
	{
		/// <summary>
		/// This is a dummy class which replaces a symbol reference to the .fla file which is not in this version
		/// </summary>	
		public function PlayerFla( )
		{
			this.graphics.beginFill( 0x00ff00 );
			this.graphics.drawRect( -Constants.kPlayerWidth/2, -Constants.kPlayerWidth/2, Constants.kPlayerWidth, Constants.kPlayerWidth );
			this.graphics.endFill( );
		}
	}
}

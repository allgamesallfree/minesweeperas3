/**
 * Builds a Tile object, with all necessary states
 * Author: Maxwell Stein
 */
package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class Tile extends MovieClip
	{
		public var xValue:int;
		public var yValue:int;
		public var xCor:int;
		public var yCor:int;
		public var numMines:int;
		public var pressed:Boolean = false;
		public var hasMine:Boolean = false;
		public var flagged:Boolean = false;
		public var clip:Object;
		public function Tile(xValue:int, yValue:int, xCor:int, yCor:int)
		{
			this.x = xValue;
			this.y = yValue;
			this.xCor = xCor;
			this.yCor = yCor;
			this.numMines = numMines;
			this.hasMine = hasMine;
			this.pressed = pressed;
			this.flagged = flagged;
			this.gotoAndStop(1);
			this.buttonMode = true;
		}
		public function setHasMine()
		{
			this.hasMine = true;
			//this.gotoAndStop(4);
		}
		public function setFlagged() 
		{
			if(this.pressed == false) 
			{
				if(this.flagged == false)
				{
					this.flagged = true;
					this.gotoAndStop(2);
				}
				else
				{
					this.flagged = false;
					this.gotoAndStop(1);
				}
			}
		}
		public function setPressed()
		{
			if(this.flagged == false)
			{
				this.pressed = true;
				this.gotoAndStop(3);
				if(numMines > 0) 
				{
					this.numNear.text = numMines.toString();
				}
			}
		}
		public function setNumNear()
		{
			this.numMines++;
		}
	}
}
/**
 * Core class for setting up the game screen
 * Author: Maxwell Stein
 */
package
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	public class Game
	{
		private var parent:MovieClip;
		private var placeFlag:Boolean = true;
		public function Game(parent:MovieClip) 
		{
			this.parent = parent; //Make methods in game class accessible and back tracking to menu possible
		}
		public function startGame(difficulty:int) 
		{
			if(difficulty == 1) 
			{
				parent.setBoardWidth(9);
				parent.setBoardHeight(9);
				parent.setMines(10);
			} 
			else if(difficulty == 2)
			{
				parent.setBoardWidth(13);
				parent.setBoardHeight(13);
				parent.setMines(12);
			}
			else 
			{
				parent.setBoardWidth(16);
				parent.setBoardHeight(16);
				parent.setMines(15);
			}
			parent.setTotalTiles(); //Sets tile count using board width and height
			parent.setRevealed(0);
			parent.callTileController();
		}
	}
}
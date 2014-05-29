/**
 * Builds our grid and defines the core functionality of tiles
 * Author: Maxwell Stein
 */
package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TileController
	{
		private var parent:MovieClip;
		private var clips:Array = new Array();
		private var SCREEN_WIDTH:int = 640;
		private var SCREEN_HEIGHT:int = 480;
		private var TILE_SIZE:int = 30;
		private var startX:int;
		private var startY:int;
		private var posX:int;
		private var posY:int;
		private var tileNum:int;
		private var minesRemaining;
		private var randomSpace:int;
		private var tile:Tile; //Dummy tile to use in methods
		private var reachedMine:Boolean;
		public function TileController(parent:MovieClip) 
		{
			this.parent = parent; //Make methods in TileController class accessible and back tracking to menu possible
		}
		public function setGrid() 
		{
			buildGrid(parent.getBoardWidth(), parent.getBoardHeight());
			placeMines();
		}
		private function buildGrid(x:int, y:int) 
		{
			for(var i:int = 0; i < x; i++)
			{
				for(var j:int = 0; j < y; j++)
				{
					startX = (SCREEN_WIDTH - x * TILE_SIZE) / 2; // to center our tiles horizontally
					startY = (SCREEN_HEIGHT - y * TILE_SIZE) / 2; // to center our tiles vertically
					posX = startX + i*TILE_SIZE;
					posY = startY + j*TILE_SIZE;
					var tile = new Tile(posX, posY, i, j);
					tile.addEventListener(MouseEvent.CLICK, tappedTile);
					clips.push(tile);
					parent.addChild(tile);
				}
			}
		}
		private function tappedTile(e:MouseEvent) 
		{
			checkTileAt(e.currentTarget.xCor, e.currentTarget.yCor, e.ctrlKey);
		}
		private function checkTileAt(x:int, y:int, shouldFlag:Boolean)
		{
			tileNum = x*parent.getBoardWidth() + y; //Determines place in array based on x and y coordinates
			if(clips[tileNum] != null)
			{
				tile = clips[tileNum]; //gets this particular tile in the array
				reachedMine = false;
				if(shouldFlag) 
				{
					tile.setFlagged(); //With control down we place a flag
				}
				else
				{
					if(tile.hasMine == false && tile.pressed == false)
					{
						toggleTile();
						hasNeighbors(x, y, false);
					}
					else
					{
						parent.loadLose();
					}
				}
			}
		}
		private function checkNeighborAt(x:int, y:int, mine:Boolean)
		{
			tileNum = x*parent.getBoardWidth() + y; //Determines place in array based on x and y coordinates
			if(clips[tileNum] != null)
			{
				tile = clips[tileNum];
				if(mine == false) //If we are checking neighbors due to a click, reveal path
				{
					if(tile.hasMine == false && tile.pressed == false && tile.flagged == false)
					{
						toggleTile();
						if(tile.numMines == 0)
						{
							hasNeighbors(x, y, false);
						}
					}
				}
				else
				{
					tile.setNumNear(); //If we are checking neighbors because we placed a mine, set adjacencies
				}
			}
		}
		private function hasNeighbors(x:int, y:int, mine:Boolean)
		{
			tileNum = x*parent.getBoardWidth() + y; //Determines place in array based on x and y coordinates
			if(clips[tileNum] != null) //Make sure game board hasn't been cleared before running method
			{
				tile = clips[tileNum];
				if(tile.yCor == 0) //We now go through all permutations to determine if the tile has neighbors
				{
					checkNeighborAt(x, y+1, mine);
					if(tile.xCor == 0) //Top left tile
					{
						checkNeighborAt(x+1, y, mine);
						checkNeighborAt(x+1, y+1, mine);
					}
					else if(tile.xCor == parent.getBoardWidth()-1) //Top right tile
					{
						checkNeighborAt(x-1, y, mine);
						checkNeighborAt(x-1, y-1, mine);
					}
					else //Any tile top row
					{
						checkNeighborAt(x-1, y, mine);
						checkNeighborAt(x+1, y, mine);
						checkNeighborAt(x-1, y+1, mine);
						checkNeighborAt(x+1, y+1, mine);
					}
				}
				else if(tile.yCor == parent.getBoardHeight()-1) 
				{
					checkNeighborAt(x, y-1, mine);
					if(tile.xCor == 0) //Bottom left tile
					{
						checkNeighborAt(x+1, y-1, mine);
						checkNeighborAt(x+1, y, mine);
					}
					else if(tile.xCor == parent.getBoardWidth() -1) //Bottom right tile
					{
						checkNeighborAt(x-1, y-1, mine);
						checkNeighborAt(x-1, y, mine);
					}
					else  //Any tile bottom row
					{
						checkNeighborAt(x-1, y-1, mine);
						checkNeighborAt(x+1, y-1, mine);
						checkNeighborAt(x-1, y, mine);
						checkNeighborAt(x+1, y, mine);
					}
				}
				else
				{
					checkNeighborAt(x, y-1, mine);
					checkNeighborAt(x, y+1, mine);
					if(tile.xCor == 0)  //Any left tile
					{
						checkNeighborAt(x+1, y-1, mine);
						checkNeighborAt(x+1, y, mine);
						checkNeighborAt(x+1, y+1, mine);
					}
					else if(tile.xCor == parent.getBoardWidth() -1) //Any right tile
					{
						checkNeighborAt(x-1, y-1, mine);
						checkNeighborAt(x-1, y, mine);
						checkNeighborAt(x-1, y+1, mine);
					}
					else //All other tiles, check all neighbors
					{
						checkNeighborAt(x-1, y, mine);
						checkNeighborAt(x+1, y, mine);
						checkNeighborAt(x+1, y+1, mine);
						checkNeighborAt(x-1, y-1, mine);
						checkNeighborAt(x+1, y-1, mine);
						checkNeighborAt(x-1, y+1, mine);
					}
				}
			}
		}
		public function clearTiles()
		{
			for(var i:int = 0; i<clips.length; i++)
			{
				tile = clips[i];
				parent.removeChild(tile);
				if(i >= clips.length-1) 
				{
					clips.splice(0);
				}
			}
		}
		private function placeMines() 
		{
			minesRemaining = parent.getMines(); //Determine how many mines we need to place.
			while(minesRemaining > 0) 
			{
				randomSpace = Math.random() * (parent.getTotalTiles());
				tile = clips[randomSpace];
				if(tile.hasMine == false)  //Verify tile doesn't already have a mine before placing one down
				{
					tile.setHasMine();
					minesRemaining--;
					hasNeighbors(tile.xCor, tile.yCor, true);
				}
			}
		}
		private function toggleTile()
		{
			parent.setRevealed(parent.getRevealed()+1);
			tile.setPressed();
			if(parent.getRevealed() == parent.getTotalTiles() - parent.getMines())
			{
				parent.loadWin();
			}
		}
	}
}
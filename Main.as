/**
 * Handles screen switching and is the helper class for many core methods in other classes
 * Author: Maxwell Stein
 */
package
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class Main extends MovieClip
	{
		public var difficulty:int; // we'll use this to determine easy/medium/hard
		public var mines:int;
		public var boardWidth:int;
		public var boardHeight:int;
		public var totalTiles:int;
		public var revealed:int;
		private var playButton:PlayButton = new PlayButton();
		private var instructionsButton:InstructionsButton = new InstructionsButton();
		private var backButton:BackButton = new BackButton();
		private var easyButton:EasyButton = new EasyButton();
		private var mediumButton:MediumButton = new MediumButton();
		private var hardButton:HardButton = new HardButton();
		private var playAgainButton:PlayAgainButton = new PlayAgainButton();
		private var instructionsText:InstructionsText = new InstructionsText();
		private var difficultyText:DifficultyText = new DifficultyText();
		private var winText:WinText = new WinText();
		private var loseText:LoseText = new LoseText();
		private var title:Title = new Title();
		private var game:Game;
		private var tileController:TileController;
		public function Main()
		{
			game = new Game(this);
			tileController = new TileController(this);
			loadMenu(); //Start the game by initializing the menu
		}
		private function loadMenu() 
		{
			playButton.y = 150; //Set y coordinates for our buttons
			instructionsButton.y = 270;
			addChild(title);
			addChild(playButton);
			addChild(instructionsButton);
			playButton.addEventListener(MouseEvent.CLICK, startDifficulty); //Add click events for our core UI
			instructionsButton.addEventListener(MouseEvent.CLICK, startInstructions);
		}
		private function loadDifficulty()
		{
			clearMenu(); //Before loading the difficulty screen, clear the menu
			easyButton.y = 115; //Coordinate y locations for difficulty buttons
			mediumButton.y = 200;
			hardButton.y = 285;
			backButton.y = 390;
			addChild(difficultyText);
			addChild(easyButton);
			addChild(mediumButton);
			addChild(hardButton);
			addChild(backButton);
			easyButton.addEventListener(MouseEvent.CLICK, pickEasy);
			mediumButton.addEventListener(MouseEvent.CLICK, pickMedium);
			hardButton.addEventListener(MouseEvent.CLICK, pickHard);
			backButton.addEventListener(MouseEvent.CLICK, backDifficulty);
		}
		private function loadInstructions()
		{
			clearMenu(); //Before loading the instructions screen, clear the menu
			backButton.y = 390;
			addChild(instructionsText);
			addChild(backButton);
			backButton.addEventListener(MouseEvent.CLICK, backInstructions);
		}
		public function loadLose()
		{
			tileController.clearTiles();
			playAgainButton.y = 390;
			addChild(loseText);
			addChild(playAgainButton);
			playAgainButton.addEventListener(MouseEvent.CLICK, backLose);
		}
		public function loadWin()
		{
			playAgainButton.y = 390;
			addChild(winText);
			addChild(playAgainButton);
			playAgainButton.addEventListener(MouseEvent.CLICK, backWin);
			tileController.clearTiles();
		}
		private function clearInstructions() 
		{
			removeChild(instructionsText);
			removeChild(backButton);
			backButton.removeEventListener(MouseEvent.CLICK, backInstructions);
		}
		private function clearDifficulty() 
		{
			
			removeChild(difficultyText);
			removeChild(easyButton);
			removeChild(mediumButton);
			removeChild(hardButton);
			removeChild(backButton);
			backButton.removeEventListener(MouseEvent.CLICK, backDifficulty);
			easyButton.removeEventListener(MouseEvent.CLICK, pickEasy);
			mediumButton.removeEventListener(MouseEvent.CLICK, pickMedium);
			hardButton.removeEventListener(MouseEvent.CLICK, pickHard);
		}
		private function clearMenu()
		{
			removeChild(title);
			removeChild(playButton);
			removeChild(instructionsButton);
			playButton.removeEventListener(MouseEvent.CLICK, startDifficulty); 
			instructionsButton.removeEventListener(MouseEvent.CLICK, startInstructions);
		}
		private function clearLose()
		{
			removeChild(loseText);
			removeChild(playAgainButton);
			playAgainButton.removeEventListener(MouseEvent.CLICK, backLose); 
		}
		private function clearWin()
		{
			removeChild(winText);
			removeChild(playAgainButton);
			playAgainButton.removeEventListener(MouseEvent.CLICK, backWin); 
		}
		private function startDifficulty(e:MouseEvent) 
		{
			loadDifficulty();
		}
		private function startInstructions(e:MouseEvent)
		{
			loadInstructions();
		}
		private function backInstructions(e:MouseEvent) 
		{
			clearInstructions(); //To return to the menu clear instructions first
			loadMenu();
		}
		private function backDifficulty(e:MouseEvent) 
		{
			clearDifficulty(); //To return to the menu clear instructions first
			loadMenu();
		}
		private function backLose(e:MouseEvent) 
		{
			clearLose(); //To return to the menu clear instructions first
			loadMenu();
		}
		private function backWin(e:MouseEvent) 
		{
			clearWin(); //To return to the menu clear instructions first
			loadMenu();
		}
		public function callTileController()
		{
			tileController.setGrid();
		}
		public function pickEasy(e:MouseEvent) 
		{
				setDifficulty(1);
				clearDifficulty();
				game.startGame(1); //Start the game!
		}
		public function pickMedium(e:MouseEvent) 
		{
			setDifficulty(2);
			clearDifficulty();
			game.startGame(2); //Start the game!
		}
		public function pickHard(e:MouseEvent) 
		{
			setDifficulty(3);
			clearDifficulty();
			game.startGame(3); //Start the game!
		}
		public function setDifficulty(makeDifficulty:int) 
		{
			difficulty = makeDifficulty;
		}
		public function getDifficulty()
		{
			return difficulty; //Publically accessible so we can access this from other classes
		}
		public function setMines(makeMines:int) 
		{
			mines = makeMines;
		}
		public function getMines()
		{
			return mines; //Publically accessible so we can access this from other classes
		}
		public function setBoardWidth(makeBoardWidth:int) 
		{
			boardWidth = makeBoardWidth;
		}
		public function getBoardWidth()
		{
			return boardWidth; //Publically accessible so we can access this from other classes
		}
		public function setBoardHeight(makeBoardHeight:int) 
		{
			boardHeight = makeBoardHeight;
		}
		public function getBoardHeight()
		{
			return boardHeight; //Publically accessible so we can access this from other classes
		}
		public function setTotalTiles() 
		{
			totalTiles = boardWidth * boardHeight; //Determine number of tiles using boardWidth and boardHeight
		}
		public function getTotalTiles()
		{
			return totalTiles; //Publically accessible so we can access this from other classes
		}
		public function setRevealed(makeRevealed:int) 
		{
			revealed = makeRevealed; 
		}
		public function getRevealed()
		{
			return revealed; //Publically accessible so we can access this from other classes
		}
	}
}
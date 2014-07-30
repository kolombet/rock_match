package com.rockmatch.game
{
	import flash.utils.getDefinitionByName;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		private var tiles:Array = [];
		
		public function Game()
		{
			showField("com.rockmatch.game.Field");
			showTile("com.rockmatch.game.Tile");
		}
		
		private function showField(name:String):void
		{
			var SceneClass:Class = getDefinitionByName(name) as Class;
			var  field:Field = new SceneClass() as Field;
			field.x = Field.FIELD_START_X;
			field.y = Field.FIELD_START_Y;
			addChild(field);
		}
		
		private function showTile(name:String):void
		{
			var SceneClass:Class = getDefinitionByName(name) as Class;
			
			for(var i:int = 0; i<Field.SIZE; i++) {
				tiles[i] = [];
				for(var j:int = 0; j<Field.SIZE; j++) {
					var tile:Tile = new SceneClass() as Tile;
					
					if( i == 0 && j ==0) {
						tile.x = Tile.START_X;
						tile.y = Tile.START_Y;						
					} else {
						tile.x += Tile.START_X + (tile.width*j);
						tile.y += Tile.START_Y + (tile.height*i);
					}
					
					addChild(tile);
				}
			}
		}
	}
}
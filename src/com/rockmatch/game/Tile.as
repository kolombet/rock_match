package com.rockmatch.game
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Tile extends Sprite
	{
		public static const FRAME_RATE:int = 60;
		public static const START_X:Number = 265;
		public static const START_Y:Number = 161;
	
		private var sContentScaleFactor:int = 1;
		private var mMovie:MovieClip;
		private var sTextures:Dictionary = new Dictionary();
		private var _id:int;
		
		public function Tile()
		{
			var frames:Vector.<Texture> = getTextureAtlas().getTextures("tile");
			mMovie = new MovieClip(frames, FRAME_RATE);
			addChild(mMovie);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage(event:Event):void
		{
			mMovie.stop();
			_id  = Math.random()*5;
			mMovie.currentFrame = _id;
			Starling.juggler.add(mMovie);
		}
		
		private function getTextureAtlas():TextureAtlas
		{
			var texture:Texture = getTexture("AtlasTexture");
			var xml:XML = XML(create("AtlasXml"));
			
			return (new TextureAtlas(texture, xml));
		}
		
		private function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = create(name);
				
				if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
			}
			
			return sTextures[name];
		}
		
		private function create(name:String):Object
		{
			var textureClass:Class = AssetEmbeds;
			return new textureClass[name];
		}
		
		public function get id():int
		{
			return _id;
		}
	}
}
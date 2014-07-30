package com.rockmatch.game
{
    import flash.display.Bitmap;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Field extends Sprite
    {
		public static const SIZE:int = 8
		public static const FIELD_START_X:Number = 250;
		public static const FIELD_START_Y:Number = 150;
		
		private var sContentScaleFactor:int = 1;
		private var mMovie:Image;
		private var sTextures:Dictionary = new Dictionary();
        
        public function Field()
        {
			
			var atlas:TextureAtlas = getTextureAtlas();
			mMovie = new Image(atlas.getTexture("field") as Texture);
			addChild(mMovie);
        }
        
		public function getTextureAtlas():TextureAtlas
		{
			var texture:Texture = getTexture("AtlasTexture");
			var xml:XML = XML(create("AtlasXml"));
			
			return (new TextureAtlas(texture, xml));
		}
		
		public function getTexture(name:String):Texture
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
		
    }
}
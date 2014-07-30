package com.rockmatch.game
{
    public class AssetEmbeds
    {
		[Embed(source="../../../../assets/game/atlas.xml", mimeType="application/octet-stream")]
		public static const AtlasXml:Class;
		
		[Embed(source="../../../../assets/game/atlas.png")]
		public static const AtlasTexture:Class;
    }
}
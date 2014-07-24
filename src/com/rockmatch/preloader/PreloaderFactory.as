/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 22:48
 */
package com.rockmatch.preloader {
	import com.merlinds.unitls.Resolutions;
	import com.rockmatch.layout.Layout;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	internal class PreloaderFactory {
		[Embed(source="../../../../assets/logo.png", mimeType="image/png")]
		private static var LogoText:Class;
		[Embed(source="../../../../assets/loading_text.png", mimeType="image/png")]
		private static var Loading:Class;
		[Embed(source="../../../../assets/duck.png", mimeType="image/png")]
		private static var Logo:Class;
		[Embed(source="../../../../assets/copyright_text.png", mimeType="image/png")]
		private static var CopyrightText:Class;

		private static const BG_COLOR:uint = 0x2C585F;
		private static var _instance:PreloaderFactory;

		public static const LOGO:String = "Logo";
		public static const LOGO_TEXT:String = "LogoText";
		public static const ANIMATION:String = "Loading";
		public static const COPYRIGHT:String = "CopyrightText";

		private var _layout:Layout;
		//==============================================================================
		//{region							PUBLIC METHODS
		public static function getInstance():PreloaderFactory {
			if(_instance == null){
				_instance = new PreloaderFactory(new SingletonKey());
			}
			return _instance;
		}

		public function PreloaderFactory(singletonKey:SingletonKey) {
			if(singletonKey == null){
				throw new ArgumentError("Layout is singleton. Use getInstance() instead");
			}
			_layout = Layout.getInstance();
		}

		public function getSource(name:String):BitmapData{
			var source:Bitmap = new PreloaderFactory[name]();
			if(name == ANIMATION){
				return new PreloaderAnimation(source.bitmapData, 10, 0.2);
			}else{
				return this.resize(source.bitmapData);
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function resize(bitmapData:BitmapData):BitmapData {
			var width:int = _layout.resolution * bitmapData.width / Resolutions.FULL_HD;
			var height:int = _layout.resolution * bitmapData.height / Resolutions.FULL_HD;
			var result:BitmapData = new BitmapData(width, height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.a =  _layout.resolution  / Resolutions.FULL_HD;
			matrix.d =  _layout.resolution  / Resolutions.FULL_HD;
			result.draw(bitmapData, matrix, null, null, null, true);
			return result;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get background():BitmapData {
			return new BitmapData(_layout.width, _layout.height,
					false, BG_COLOR);
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
class SingletonKey{}

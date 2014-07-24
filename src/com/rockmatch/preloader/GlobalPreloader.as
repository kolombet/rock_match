/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 21:30
 */
package com.rockmatch.preloader {
	import com.merlinds.launchers.BasePreloader;
	import com.rockmatch.layout.Layout;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;

	/** Global preloader of the application **/
	public class GlobalPreloader extends BasePreloader {
		//==============================================================================
		//{region							EMBEDS
		//} endregion EMBEDS ===========================================================
		private var _layout:Layout;
		private var _background:Bitmap;
		private var _threshold:int;

		private var _animation:PreloaderAnimation;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GlobalPreloader(threshold:int = 10) {
			_threshold = threshold;
			super();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function redraw(event:Event = null):void{
			var matrix:Matrix = new Matrix(1, 0, 0, 1);
			var background:BitmapData = PreloaderFactory.getInstance().background;
			//draw logo
			var source:BitmapData = PreloaderFactory.getInstance().getSource(PreloaderFactory.LOGO);
			var logoHeight:int = source.height * matrix.a;
			matrix.tx = _layout.width - source.width * matrix.a >> 1;
			matrix.ty = _layout.height - logoHeight >> 1;
			background.draw(source, matrix, null, null, null, true);
			source = PreloaderFactory.getInstance().getSource(PreloaderFactory.LOGO_TEXT);
			matrix.tx = _layout.width - source.width * matrix.a >> 1;
			matrix.ty += source.height >> 1;
			background.draw(source, matrix, null, null, null, true);
			source = PreloaderFactory.getInstance().getSource(PreloaderFactory.COPYRIGHT);
			matrix.tx = _layout.width - source.width * matrix.a >> 1;
			matrix.ty = _layout.height - source.height;
			background.draw(source, matrix, null, null, null, true);
			//add bg to stage
			_background = new Bitmap(background);
			_background.bitmapData.lock();
			this.addChild(_background);
			source = PreloaderFactory.getInstance().getSource(PreloaderFactory.ANIMATION);
			_animation = source as PreloaderAnimation;
			_animation.depth.x = _layout.width - 20 - source.width >> 1;
			_animation.depth.y = (_layout.height / 10) * 7;
			_animation.background = background;
			this.update();
		}

		override protected function initialize():void {
			_layout = Layout.getInstance();
			_layout.addEventListener(Event.RESIZE, this.redraw);
			this.redraw();
		}

		override public function destroy():void {
			this.removeChildren();
			_background.bitmapData.dispose();
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		override public function update(percent:Number = 0):void {
			if(_threshold > 0){
				_threshold--;
				return;
			}
			_animation.update();
			_background.bitmapData.unlock(_animation.rect);
			_background.bitmapData.copyPixels(_animation, _animation.rect,_animation.depth);
			_background.bitmapData.lock();
		}

//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}

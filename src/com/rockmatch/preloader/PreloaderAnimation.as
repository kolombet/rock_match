/**
 * User: MerlinDS
 * Date: 11.06.2014
 * Time: 8:03
 */
package com.rockmatch.preloader {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class PreloaderAnimation extends BitmapData {

		private var _depth:Point;
		private var _background:BitmapData;
		private var _glyphs:Vector.<BitmapGlyph>;
		//movement
		private static const MAX_COS:Number = 0.996;
		private var _index:int;
		private var _force:int;
		private var _limit:int;
		private var _koef:Number;
		private var _speed:Number;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PreloaderAnimation(source:BitmapData, force:int = 10, speed:Number = 0.1) {
			_depth = new Point(0, 0);
			_koef = 0;
			_speed = speed;
			_force = force;
			_limit = source.height - _force;
			this.parseSource(source);
			super(source.width, source.height * 2, true, 0);
		}

		public function update():void {
			this.unlock();
			//clear previous frame
			this.copyPixels(_background, _background.rect, new Point());
			//draw next frame
			var n:int = _glyphs.length;
			for(var i:int = 0; i < n; i++){
				var glyph:BitmapGlyph = _glyphs[i];
				if(i == _index){
					_koef += _speed;
					glyph.depth.y = Math.cos(_koef) * _force + _limit;
					if(Math.cos(_koef) >= MAX_COS){
						glyph.depth.y = glyph.y;
						_koef = 0;
						if(++_index >= n){
							_index = 0;
						}
					}
				}
				this.copyPixels(glyph, glyph.rect, glyph.depth, null, null, true);
			}
			this.lock();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function parseSource(source:BitmapData):void {
			_glyphs = new <BitmapGlyph>[];
			var glyphBuffer:BitmapGlyph;

			var rect:Rectangle = new Rectangle(0, 1, 0, source.height - 1);

			var i:int;
			var x:int = 0;
			var prev:int = 0;
			var n:int = source.width;
			const depth:Point = new Point();

			for (i = 0; i < n; i++) {
				if (source.getPixel(i, 0) == 0xFFFFFF) {//marker of the glyph is white
					//calculate glyph rectangle. He lays between marker
					rect.x = prev;
					rect.width = i - prev << 1;
					prev += rect.width;
					//get buffer
					glyphBuffer = new BitmapGlyph(rect.width, rect.height);
					glyphBuffer.copyPixels(source, rect, depth);
					glyphBuffer.depth.y = source.height;
					glyphBuffer.y = source.height;
					glyphBuffer.depth.x = x;
					_glyphs[_glyphs.length] = glyphBuffer;
					x += glyphBuffer.width;
				}
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get depth():Point {
			return _depth;
		}

		public function set background(value:BitmapData):void {
			if(value != null){
				//cut background
				_background = new BitmapData(this.width, this.height, false, 0xFF000000);
				_background.copyPixels(value, new Rectangle(_depth.x, _depth.y, this.width, this.height), new Point());
				value = _background;
			}
			_background = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

import flash.display.BitmapData;
import flash.geom.Point;

class BitmapGlyph extends BitmapData{

	public var depth:Point;
	public var y:int;

	public function BitmapGlyph(width:int, height:int) {
		super(width, height, true, 0);
		this.depth = new Point(0, 0);
	}

}
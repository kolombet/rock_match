/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 20:15
 */
package com.rockmatch.layout {

	import com.merlinds.debug.log;
	import com.merlinds.unitls.Resolutions;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.system.Capabilities;

	/** Will be dispatched after stage resizing **/
	[Event(type="flash.events.Event", name="resize")]

	/** Main layout of the application**/
	public final class Layout extends EventDispatcher{

		private static var _instance:Layout;

		private var _stage:Stage;
		private var _base:String;
		//
		private var _width:int;
		private var _height:int;
		//get from com.merlinds.unitls.Resolution
		private var _resolution:int;

		//==============================================================================
		//{region							PUBLIC METHODS
		public static function getInstance():Layout {
			if(_instance == null){
				_instance = new Layout(new SingletonKey());
			}
			return _instance;
		}

		public function Layout(singletonKey:SingletonKey) {
			if(singletonKey == null){
				throw new ArgumentError("Layout is singleton. Use getInstance() instead");
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		/**
		 * Initialize application layout
		 * @param stage Application stage
		 * @param base Layout base, by default LayoutBaseType.STAGE
		 * @see com.loonyquack.layouts.LayoutBaseType
		 **/
		public function initialize(stage:Stage, base:String = LayoutBaseType.STAGE):void {
			log(this, "initialize");
			_stage = stage;
			_base = base;
			_stage.addEventListener(Event.RESIZE, this.resizeHandler);
			//initial resize
			_stage.dispatchEvent( new Event(Event.RESIZE));
		}

		override public function toString():String{
			return "[object Layout(width = " + _width + ", height = " + _height + "" +
					", resolution = " + Resolutions.toString(_resolution) +")]";
		}

		public function scaleX(value:int):Number {
			var scaled:Number = ( value / Resolutions.width(Resolutions.FULL_HD) ) * _width;
			return scaled / value;
		}

		public function scaleY(value:int):Number {
			var scaled:Number = ( value / Resolutions.width(Resolutions.FULL_HD) ) * _height;
			return scaled / value;
		}
		//converters
		public function convertPoint(point:Point):Point{
			point.x = this.convertX(point.x);
			point.y = this.convertY(point.y);
			return point;
		}

		public function invertPoint(point:Point):Point{
			point.x = this.invertX(point.x);
			point.y = this.invertY(point.y);
			return point;
		}

		[Inline]
		public function convertX(value:Number):int {
			return _width * ( ( 1 + value) / 2 );
		}

		[Inline]
		public function convertY(value:Number):int {
			return _height * ( ( 1 + value) / 2 );
		}

		[Inline]
		public function invertX(value:Number):Number {
			return 2 * ( value / _width ) - 1;
		}

		[Inline]
		public function invertY(value:Number):Number {
			return 2 * ( value / _height ) - 1;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function resizeHandler(event:Event):void {
			var resized:Boolean;
			if(_base == LayoutBaseType.SCREEN){
				resized = _width != Capabilities.screenResolutionX || _height != Capabilities.screenResolutionY ;
				_width = Capabilities.screenResolutionX;
				_height = Capabilities.screenResolutionY;
			}else if(_base == LayoutBaseType.STAGE){
				resized = _width != _stage.stageWidth || _height != _stage.stageHeight ;
				_width = _stage.stageWidth;
				_height = _stage.stageHeight;
			}

			if(resized){
				_resolution = Resolutions.closestInValue(_width);
				log(this, "resizeHandler");
				//Dispatch events for subscribers
				this.dispatchEvent(event);
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get width():int {
			return _width;
		}

		public function get height():int {
			return _height
		}

		public function get resolution():int {
			return _resolution;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
class SingletonKey{}
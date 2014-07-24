/**
 * User: MerlinDS
 * Date: 18.06.2014
 * Time: 18:19
 */
package com.rockmatch.layout {
	public class LayoutPoint {

		private var _layout:Layout;

		private var _x:Number;
		private var _y:Number;

		private var _realX:int;
		private var _realY:int;

		public function LayoutPoint(x:Number = 0, y:Number = 0) {
			_layout = Layout.getInstance();
			this.x = x;
			this.y = y;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function moveObject(object:Object, offsetX:int = 0, offsetY:int = 0):LayoutPoint {
			object.x = _realX + offsetX;
			object.y = _realY + offsetY;
			return this;
		}

		public function toString():String {
			return "[object LayoutPoint(x = " + _x + ", y = " + _y + ", " +
					"realX = " + _realX + ", realY = " + _realY + ")]";
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get x():Number {
			return _x;
		}

		public function set x(value:Number):void {
			_x = value;
			_realX = _layout.convertX(value);
		}

		public function get y():Number {
			return _y;
		}

		public function set y(value:Number):void {
			_y = value;
			_realY = _layout.convertY(value);
		}

		public function get realX():int {
			return _realX;
		}

		public function set realX(value:int):void {
			_realX = value;
		}

		public function get realY():int {
			return _realY;
		}

		public function set realY(value:int):void {
			_realY = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

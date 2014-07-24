/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 19:49
 */
package com.merlinds.launchers {
	import flash.display.Sprite;
	import flash.events.Event;

	/** Base abstract preloader class **/
	public class BasePreloader extends Sprite implements IPreloader {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function BasePreloader() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.preInitialization);
			super();
		}

		public function show():void {
			this.visible = true;
		}

		public function hide():void {
			this.visible = false;
		}

		public function destroy():void {
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function initialize():void{

		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function preInitialization(event:Event):void {
			this.removeEventListener(event.type, this.preInitialization);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.preDestruction);
			this.initialize();
		}

		private function preDestruction(event:Event):void {
			this.removeEventListener(event.type, this.preDestruction);
			this.destroy();
		}

		public function update(percent:Number = 0):void {
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}

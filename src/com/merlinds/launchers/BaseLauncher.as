/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 19:33
 */
package com.merlinds.launchers {
	import com.merlinds.debug.log;

	import flash.display.DisplayObject;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;

	/** Base launcher of the application **/
	public class BaseLauncher extends Sprite {

		private var _preloader:IPreloader;
		private var _monitor:DisplayObject;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function BaseLauncher() {
			log(this, "constructor");
			this.addEventListener(Event.ADDED_TO_STAGE, this.preInitialization);
			super();
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			child = super.addChild(child);
			if(_monitor != null && _monitor.parent == this){
				this.setChildIndex(_monitor, this.numChildren - 1);
			}
			return child;
		}

//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function preInitialization(event:Event):void {
			log(this, "preInitialization");
			this.removeEventListener(event.type, this.preInitialization);
			this.addEventListener(Event.INIT, this.initialization);
			this.addEventListener(Event.COMPLETE, this.initializationComplete);
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			log(this, "initialization");
			this.dispatchEvent(new Event(Event.INIT));
		}

		/** Initialization of application was complete **/
		private function initializationComplete(event:Event):void{
			log(this, "start");
			if(_preloader != null){
				//First preloader update
				_preloader.update();
			}
			this.removeEventListener(Event.INIT, this.initialization);
			this.removeEventListener(Event.COMPLETE, this.initializationComplete);
			setTimeout(this.start, 0);
		}

		/** Initialize application **/
		protected function initialization(event:Event):void{
			log(this, "initializationComplete");
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		/** Start application **/
		protected function start():void{
			if(_monitor != null){
				_monitor.y = this.stage.stageHeight - this.monitor.height;
			}
			if(_preloader != null){
				_preloader.hide();
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		/** application global preloader **/
		protected final function get preloader():IPreloader {
			return _preloader;
		}
		/** application global preloader **/
		protected final function set preloader(value:IPreloader):void {
			if(_preloader != null && _preloader != value){
				_preloader.hide();
				this.removeChild(_preloader as DisplayObject);
			}else if(_preloader == null && _preloader != value){
				this.addChild(value as DisplayObject);
				value.show();
			}
			_preloader = value;
		}

		public function set monitor(value:DisplayObject):void {
			if(_monitor != null && _monitor.parent == this){
				this.removeChild(_monitor);
			}
			_monitor = value;
			if(_monitor != null){
				super.addChild(_monitor);
			}
		}

		public function get monitor():DisplayObject {
			return _monitor;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

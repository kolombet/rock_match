/**
 * User: MerlinDS
 * Date: 24.07.2014
 * Time: 16:55
 */
package com.rockmatch {
	import com.merlinds.debug.log;
	import com.merlinds.launchers.BaseLauncher;
	import com.rockmatch.layout.Layout;
	import com.rockmatch.layout.LayoutBaseType;
	import com.rockmatch.preloader.GlobalPreloader;

	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;

	import flash.events.Event;
	import flash.utils.setTimeout;

	import net.hires.debug.Stats;

	/** Application launcher **/
	[SWF(frameRate=60, width=1024, height=768)]
	public class WebLauncher extends BaseLauncher {

		private var _view:DisplayObjectContainer;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function WebLauncher() {
			super();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialization(event:Event):void {
			Layout.getInstance().initialize(this.stage, LayoutBaseType.STAGE);//initialize Layout
			this.monitor = new Stats();//add fps monitor
			_view = new Sprite();//main view
			this.addChild(_view);
			//init frameworks and other things here
			//start download sources
			setTimeout(this.start, 3000);//для наглядности
			//initialize preloader
			this.addEventListener(Event.ENTER_FRAME, timerHandler);
		}

		override protected function start():void {
			//all was initialized, hide preloader and start application
			//TODO:	Use log, warning, error, instead of trace!
			log(this, 'start');
			//для наглядности
			var test:Shape = new Shape();
			test.graphics.beginFill(0xFF0000);
			test.graphics.drawRect(100, 100, 200, 200);
			test.graphics.endFill();
			_view.addChild(test);

			super.start();
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function timerHandler(event:Event):void {
			if(this.preloader == null){
				this.preloader = new GlobalPreloader(0);
			}else{
				this.preloader.update();
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}

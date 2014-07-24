/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 19:44
 */
package com.merlinds.launchers {
	import com.merlinds.base.IDestroyable;
	/** Interface for preloaders **/
	public interface IPreloader extends IDestroyable{
		//==============================================================================
		//{region							METHODS
		/**
		 * Update preloader
		 * @param percent Percents from 0 to 1
		 */
		function update(percent:Number = 0):void;
		/** Show preloader **/
		function show():void;
		/** Hide preloader **/
		function hide():void;
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}

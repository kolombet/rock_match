/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 20:50
 */
package com.rockmatch.layout {
	import flash.errors.IllegalOperationError;

	/** Layout bases types enumeration **/
	public final class LayoutBaseType {
		/** Layout based on stage parameters**/
		public static const STAGE:String = "stage";
		/** Layout based on screen resolution parameters**/
		public static const SCREEN:String = "screen";

		//==============================================================================
		//{region							PUBLIC METHODS
		/**
		 * throws flash.errors.IllegalOperationError Can not be instantiated !!!
		 */
		public function LayoutBaseType() {
			throw new IllegalOperationError("Can not be instantiated");
		}
		//} endregion PUBLIC METHODS ===================================================
	}
}

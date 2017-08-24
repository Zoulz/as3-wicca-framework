/**
 * Copyright Pixelshift Interactive (c) 2015 All Rights Reserved.
 * 2015-07-15 00:02
 * @author ZoulzBig
 */
package se.pixelshift.wicca.logging
{
	import se.pixelshift.common.IDisposable;

	public interface IWiccaLogger extends IDisposable
	{
		function log(logLevel:uint, msg:String):void;
	}
}

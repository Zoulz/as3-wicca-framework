/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-11-02 08:10
 * @author Zoulz
 */
package se.pixelshift.wicca.services
{
	import se.pixelshift.common.IDisposable;
	import se.pixelshift.wicca.sound.*;

	public interface ISoundService extends IDisposable
	{
		function registerGroup(grp:ISoundGroup):void;
		function unregisterGroup(grp:ISoundGroup):void;
		function stopAllSounds():void;
		function pauseAllSounds():void;
		function resumeAllSounds():void;
	}
}

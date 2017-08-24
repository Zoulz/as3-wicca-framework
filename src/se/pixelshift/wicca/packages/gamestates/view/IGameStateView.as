/**
 * Copyright Pixelshift Interactive (c) 2014 All Rights Reserved.
 * 2014-10-14 15:17
 * @author Zoulz
 */
package se.pixelshift.wicca.packages.gamestates.view
{
	public interface IGameStateView
	{
		function activated():void;
		function deactivated():void;
		function init():void;
	}
}

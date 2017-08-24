/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-02-13
 * Time: 14:01
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.list.items.tween
{
	public class TweenData
	{
		public var target:*;
		public var duration:Number = 0;
		public var props:Object = null;
		public var delayValue:Number = 0;
		public var easing:Object = null;
		public var completeCallback:Function = null;
		public var completeArgs:Array = [ ];
		public var updateCallback:Function = null;
		public var updateArgs:Array = [ ];

		public function TweenData(target:*, duration:Number, props:Object)
		{
			this.target = target;
			this.duration = duration;
			this.props = props;
		}

		public function delay(d:Number):TweenData
		{
			delayValue = d;
			return this;
		}

		public function ease(e:Object):TweenData
		{
			easing = e;
			return this;
		}

		public function onComplete(f:Function, ...args):TweenData
		{
			completeCallback = f;
			completeArgs = args;
			return this;
		}

		public function onUpdate(f:Function, ...args):TweenData
		{
			updateCallback = f;
			updateArgs = args;
			return this;
		}
	}
}

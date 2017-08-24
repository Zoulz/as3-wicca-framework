/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-02-13
 * Time: 14:03
 * To change this template use File | Settings | File Templates.
 */
package se.pixelshift.common.list.items.tween
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.IEasing;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class ActuateTweener implements ITweener
	{
		private var _complete:Signal = new Signal();
		private var _update:Signal = new Signal();

		public function tween(data:TweenData):void
		{
			//	TODO This does not seem that smart. Maybe refactor it?
			if (data.easing != null && data.delayValue > 0)
			{
				Actuate.tween(data.target, data.duration, data.props)
						.onComplete(_complete.dispatch)
						.onUpdate(_update.dispatch)
						.delay(data.delayValue)
						.ease(data.easing as IEasing);
			}
			else if (data.easing != null)
			{
				Actuate.tween(data.target, data.duration, data.props)
					.onComplete(_complete.dispatch)
					.onUpdate(_update.dispatch)
					.ease(data.easing as IEasing);
			}
			else if (data.delayValue > 0)
			{
				Actuate.tween(data.target, data.duration, data.props)
						.onComplete(_complete.dispatch)
						.onUpdate(_update.dispatch)
						.delay(data.delayValue);
			}
			else
			{
				Actuate.tween(data.target, data.duration, data.props)
					.onComplete(_complete.dispatch)
					.onUpdate(_update.dispatch);
			}
		}

		public function get complete():ISignal
		{
			return _complete;
		}

		public function get update():ISignal
		{
			return _update;
		}
	}
}

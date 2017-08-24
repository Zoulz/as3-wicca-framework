package se.pixelshift.common.display
{
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.utils.RectangleUtil;

	public class ViewMeasurements
	{
		public static var DEFAULT_CONTENT_WIDTH:Number = 1280;
		public static var DEFAULT_CONTENT_HEIGHT:Number	= 720;

		private var _viewPort:Rectangle = null;
		private var _actualViewPort:Rectangle = null;

		private var _contentScaleFactor:Number = 1.0;
		private var _stageSize:Point = null;
		private var _contextOffset:Point = new Point();

		private var _contentScale:Number = 1.0;
		private var _content:Rectangle = new Rectangle(0,0,DEFAULT_CONTENT_WIDTH,DEFAULT_CONTENT_HEIGHT);

		private var _contextScale:Number = 1.0;
		private var _context:Rectangle = new Rectangle(0,0,DEFAULT_CONTENT_WIDTH,DEFAULT_CONTENT_HEIGHT);

		private var _screenScale:Number = 1.0;

		private var _aspectRatio:AspectRatio = AspectRatio.Ratio_16_9;
		private var _contentCenter:Point;

		public function calculate(viewPort:Rectangle, screenSize:Point, stageSize:Point = null, contentScaleFactor:Number = 1.0, contextViewOffset:Point = null):void
		{
			var desiredViewPort:Rectangle, correctedViewPort:Rectangle, screenViewPort:Rectangle;

			_actualViewPort = viewPort.clone();
			_viewPort = viewPort.clone();
			roundViewPort(_viewPort);

			_contextOffset = contextViewOffset ? contextViewOffset.clone() : new Point();

			_contentScaleFactor = contentScaleFactor;

			// assume stage size to the same as the screensize of we don't get a value
			_stageSize = stageSize ? stageSize : screenSize.clone();

			// calculate the content scale depending on the stage size, this should handle ultrawide aswell

			// if stagesize is more than the viewport we need to scale up
			if (_stageSize.x > _viewPort.width || _stageSize.y > _viewPort.height)
				_contextScale = Math.max(_stageSize.y / DEFAULT_CONTENT_HEIGHT, _stageSize.x / DEFAULT_CONTENT_WIDTH);
			else // if not we need to scale down
				_contextScale = 1 / Math.min(DEFAULT_CONTENT_HEIGHT / _stageSize.y, DEFAULT_CONTENT_WIDTH / _stageSize.x);

			// compensate for content scale factor
			_contextScale = _contextScale / _contentScaleFactor;

			// now calculate he area in which the content is positioned

	//		// Make our view fit in the screensize
			desiredViewPort = RectangleUtil.fit(
					new Rectangle(0,0,DEFAULT_CONTENT_WIDTH,DEFAULT_CONTENT_HEIGHT),
					new Rectangle(0,0,screenSize.x,screenSize.y),
					StageScaleMode.NO_BORDER
			);

			desiredViewPort.x = Math.round(desiredViewPort.x);
			desiredViewPort.y = Math.round(desiredViewPort.y);
			desiredViewPort.width = Math.floor(desiredViewPort.width);
			desiredViewPort.height = Math.floor(desiredViewPort.height);

			_context.x = Math.round(desiredViewPort.x);
			_context.y = Math.round(desiredViewPort.y);
			_context.width = Math.floor(desiredViewPort.width);
			_context.height = Math.floor(desiredViewPort.height);

			// store the content space befire we convert to global
			_content = _context.clone();

			// in case the viewport match the context position there's no need to compensate for it, either we
			// move the viewport or the context. not both :).. oh I hate this class
			_context.x = _context.x + Math.abs(_viewPort.x);
			_context.y = _context.y + Math.abs(_viewPort.y);

			// now transform the position to global
			_context.x = _context.x * _contextScale / _contentScale;
			_context.y = _context.y * _contextScale / _contentScale;

			// compensate for context offset
	//		_context.x = _context.x + (_contextOffset.x / _contextScale);
	//		_context.y = _context.y + (_contextOffset.y / _contextScale);

			// now calculate scale of the content
			_contentScale = Math.max(DEFAULT_CONTENT_WIDTH / _context.width, DEFAULT_CONTENT_HEIGHT / _context.height);
			_contentScale = (1 / _contentScale);

			// content is scaled here, convert to global
			_content.x = _content.x / _contentScale;
			_content.y = _content.y / _contentScale;

			_contentCenter = new Point(_content.width / 2, _content.height / 2);

			// calculate the scale in screenspace and starling viewport
			_screenScale = _context.height / _viewPort.height;

			// calculate the aspect ratio of the screen
			_aspectRatio = AspectRatio.calculate(screenSize.x, screenSize.y);
		}

		public function get contentCenter():Point
		{
			return _contentCenter;
		}

		public function toString():String
		{
			return "Context [" +
					_context.x + ", " +
					_context.y + ", " +
					_context.width + ", " +
					_context.height + ", " +
					"scale: " + _contextScale + ", " +
					"scaleFactor: " + _contentScaleFactor + "]" +
					"\n" +
					"Content [" +
					_content.x + ", " +
					_content.y + ", " +
					_content.width + ", " +
					_content.height + ", " +
					"scale: " + _contentScale + "]" +
					"\n" +
					"Viewport [" +
					_viewPort.x + ", " +
					_viewPort.y + ", " +
					_viewPort.width + ", " +
					_viewPort.height + "]" +
					"\n" +
					"AspectRatio: " + _aspectRatio + (_aspectRatio.isUltraWide() ? " (ultrawide)" : "") +
					"\n" +
					"Stage ["+_stageSize.x+", "+_stageSize.y+"]" +
					"\n" +
					"ScreenScale: " + _screenScale;
		}

		public function get screenScale():Number 			{ return _screenScale; }
		public function get invScreenScale():Number 		{ return 1.0 / _screenScale; }
		public function get contentScale():Number 			{ return _contentScale; }
		public function get contextScale():Number 			{ return _contextScale; }
		public function get context():Rectangle 			{ return _context; }
		public function set contextOffset(value:Point):void { _contextOffset = value; }
		public function get contextOffset():Point 			{ return _contextOffset; }
		public function get content():Rectangle 			{ return _content; }
		public function get aspectRatio():AspectRatio 		{ return _aspectRatio; }

		public function alignRight(offset:Number):Number
		{
			return offset + _content.left + DEFAULT_CONTENT_WIDTH;
		}

		public function alignLeft(offset:Number):Number
		{
			return offset + -_content.left;
		}

		public function alignTop(offset:Number):Number
		{
			return offset + (_context.top);
		}

		public function alignBottom(offset:Number):Number
		{
			return offset + DEFAULT_CONTENT_HEIGHT;
		}

		public function alignVerticalCenter(objHeight:Number):Number
		{
			return (DEFAULT_CONTENT_HEIGHT - (objHeight)) * 0.5;
		}

		public function alignHorizontalCenter(objWidth:Number):Number
		{
			return (DEFAULT_CONTENT_WIDTH - (objWidth)) * 0.5;
		}

		public function getViewportWidth():Number
		{
			return DEFAULT_CONTENT_WIDTH + _content.left * 2;
		}

		public function contentSpaceToViewSpace(pos:Point):void
		{
			if (_aspectRatio.isUltraWide())
			{
				pos.x = _content.x + (pos.x * _contentScale) + (_contextOffset.x * _contentScaleFactor) ;
				pos.y = 0 + (pos.y * _contentScale) + (_contextOffset.y * _contentScaleFactor) ;

				convertToBleedingEdges(pos);
			}
			else
			{
				pos.x = ((_content.x + pos.x) * _contentScale) + (_contextOffset.x * _contentScaleFactor) ;
				pos.y = ((_content.y + pos.y) * _contentScale) + (_contextOffset.y * _contentScaleFactor) ;
			}
		}

		public function contentDimensionToViewSpace(size:Point):void
		{
			size.x *= _contentScale;
			size.y *= _contentScale;

			if (_aspectRatio.isUltraWide())
				convertToBleedingEdges(size);
		}

		public function contentDimensionToViewSpaceInverse(size:Point):void
		{
			size.x /= _contentScale;
			size.y /= _contentScale;

			if (_aspectRatio.isUltraWide())
			{
				//convertToBleedingEdges
				size.x = size.x * _screenScale;
				size.y = size.y * _screenScale;
			}
		}

		private function convertToBleedingEdges(pos:Point):void
		{
			// a fix to make ultrawide render somewhat correct
			// we don't want to crop to height so we can assume this is not the case
			// (which it isn't so this will solve the content to view space conversion problem that will happen otherwise
			if (_contextScale == 1.0)
			{
				pos.x = pos.x / _screenScale;
				pos.y = pos.y / _screenScale;
			}
			else
			{
				// the y pos in ultrawide is just abstract, need to fix that when converting to screenspace
				pos.x = pos.x / _screenScale;
				pos.y = pos.y / _screenScale;
			}
		}

		private function roundViewPort(viewPort:Rectangle):void
		{
			if (int(viewPort.x) != viewPort.x)
			{
				// we need to convert the viewport to whole pixels to avoid rounding errors
				var rest:Number = viewPort.x - int(viewPort.x);
				viewPort.x = viewPort.x - rest;
				viewPort.width = viewPort.width + (rest * 2.0);
			}
		}
	}
}

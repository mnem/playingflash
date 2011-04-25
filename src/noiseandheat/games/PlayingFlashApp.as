package noiseandheat.games
{
    import flash.events.MouseEvent;
    import noiseandheat.games.playingflash.worlds.GameWorld;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageDisplayState;
    import flash.display.StageQuality;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.utils.getTimer;

    [SWF(backgroundColor="#000000", frameRate="60", width="480", height="320")]
    public class PlayingFlashApp extends Sprite
    {
        public var time:int;
        public var timeSinceLastUpdate:int;
        public var mouseDown:Boolean;
        public var mouseReleased:Boolean;
        public var mousePressed:Boolean;
        public var currentMouseX:Number;
        public var currentMouseY:Number;

        protected var _activeWorld:GameWorld;

        public function PlayingFlashApp()
        {
            _seed = clamp(2147483647 * Math.random(), 1, 2147483646);
            addEventListener(Event.ADDED_TO_STAGE, addedToStage);
        }

        public function get framerate():Number
        {
            var fr:Number;
            try
            {
                fr = loaderInfo.frameRate;
            }
            catch(e:Error)
            {
                fr = 60;
            }

            return fr;
        }

        protected function addedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
            setStageProperties();
            init();

            time = getTimer();
            timeSinceLastUpdate = 0;

            captureStageEvents();
        }

        protected function captureStageEvents():void
        {
            addEventListener(Event.ENTER_FRAME, update);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
        }

        protected function handleMouseDown(event:MouseEvent):void
        {
            mouseDown = true;
            mousePressed = true;
        }

        protected function handleMouseUp(event:MouseEvent):void
        {
            mouseDown = false;
            mouseReleased = true;
        }

        protected function setStageProperties():void
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.NORMAL;
            stage.quality = StageQuality.LOW;
        }

        protected function set activeWorld(world:GameWorld):void
        {
            if(_activeWorld != null) removeChild(_activeWorld);
            _activeWorld = world;
            addChild(_activeWorld);
            _activeWorld.app = this;
            _activeWorld.activate();
        }

        protected function init():void
        {
            activeWorld = new GameWorld();
        }

        public function get actualFramerate():Number
        {
            return 1000.0 / timeSinceLastUpdate;
        }

        protected function update(event:Event):void
        {
            var now:int = getTimer();
            timeSinceLastUpdate = now - time;
            time = now;

            currentMouseX = stage.mouseX;
            currentMouseY = stage.mouseY;

            if(_activeWorld != null)
                _activeWorld.update();

            mouseReleased = false;
            mousePressed = false;
        }

        /**
         * (NOTE: copied from FlashPunk for this test: http://flashpunk.net/ )
         *
         * Linear interpolation between two colors.
         * @param   fromColor       First color.
         * @param   toColor         Second color.
         * @param   t               Interpolation value. Clamped to the range [0, 1].
         * return   RGB component-interpolated color value.
         */
        public function colorLerp(fromColor:uint, toColor:uint, t:Number = 1):uint
        {
            if (t <= 0) { return fromColor; }
            if (t >= 1) { return toColor; }
            var a:uint = fromColor >> 24 & 0xFF,
                r:uint = fromColor >> 16 & 0xFF,
                g:uint = fromColor >> 8 & 0xFF,
                b:uint = fromColor & 0xFF,
                dA: int = (toColor >> 24 & 0xFF) - a,
                dR: int = (toColor >> 16 & 0xFF) - r,
                dG: int = (toColor >> 8 & 0xFF) - g,
                dB: int = (toColor & 0xFF) - b;
            a += dA * t;
            r += dR * t;
            g += dG * t;
            b += dB * t;
            return a << 24 | r << 16 | g << 8 | b;
        }

        /**
         * (NOTE: copied from FlashPunk for this test: http://flashpunk.net/ )
         *
         * Clamps the value within the minimum and maximum values.
         * @param   value       The Number to evaluate.
         * @param   min         The minimum range.
         * @param   max         The maximum range.
         * @return  The clamped value.
         */
        public function clamp(value:Number, min:Number, max:Number):Number
        {
            if (max > min)
            {
                value = value < max ? value : max;
                return value > min ? value : min;
            }
            value = value < min ? value : min;
            return value > max ? value : max;
        }

        /**
         * (NOTE: copied from FlashPunk for this test: http://flashpunk.net/ )
         *
         * Returns a pseudo-random uint.
         * @param   amount      The returned uint will always be 0 <= uint < amount.
         * @return  The uint.
         */
        public function rand(amount:uint):uint
        {
            _seed = (_seed * 16807) % 2147483647;
            return (_seed / 2147483647) * amount;
        }
        protected var _seed:uint;
    }
}

package noiseandheat.games.playingflash
{
    import noiseandheat.games.playingflash.worlds.GameWorld;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageDisplayState;
    import flash.display.StageQuality;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.getTimer;

    [SWF(backgroundColor="#000000", frameRate="60", width="480", height="320")]
    public class PlayingFlashApp extends Sprite
    {
        protected var app:Application;

        protected var _activeWorld:GameWorld;

        public function PlayingFlashApp()
        {
            app = new Application(loaderInfo);

            app.width = 480;
            app.height = 320;

            addEventListener(Event.ADDED_TO_STAGE, addedToStage);
            addEventListener(Event.RESIZE, handleResize);
        }

        public function handleResize(event:Event):void
        {
            width = stage.stageWidth;
            height = stage.stageHeight;
        }

        protected function addedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
            setStageProperties();
            init();

            app.time = getTimer();
            app.timeSinceLastUpdate = 0;

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
            app.mouseDown = true;
            app.mousePressed = true;
        }

        protected function handleMouseUp(event:MouseEvent):void
        {
            app.mouseDown = false;
            app.mouseReleased = true;
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
            _activeWorld.app = app;
            _activeWorld.activate();
        }

        protected function init():void
        {
            activeWorld = new GameWorld();
        }

        protected function update(event:Event):void
        {
            var now:int = getTimer();
            app.timeSinceLastUpdate = now - app.time;
            app.time = now;

            app.mouseX = stage.mouseX;
            app.mouseY = stage.mouseY;

            if(_activeWorld != null)
                _activeWorld.update();

            app.mouseReleased = false;
            app.mousePressed = false;
        }
    }
}

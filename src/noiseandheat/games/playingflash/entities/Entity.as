package noiseandheat.games.playingflash.entities
{
    import noiseandheat.games.PlayingFlashApp;
    import noiseandheat.games.playingflash.worlds.GameWorld;

    import flash.display.Sprite;
    import flash.geom.Point;

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class Entity extends Sprite
    {
        public var app:PlayingFlashApp;
        public var world:GameWorld;

        protected var _point:Point = new Point();

        public function init():void
        {

        }

        public function update():void
        {

        }

        public function distanceToPoint(px:Number, py:Number):Number
        {
            return Math.sqrt((x - px) * (x - px) + (y - py) * (y - py));
        }

        public function moveTowards(x:Number, y:Number, amount:Number):void
        {
            _point.x = x - this.x;
            _point.y = y - this.y;

            _point.normalize(amount);

            this.x += _point.x;
            this.y += _point.y;
        }
    }
}

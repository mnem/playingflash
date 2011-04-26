package noiseandheat.games.playingflash.entities
{
    import flash.geom.Rectangle;
    import noiseandheat.games.playingflash.Application;
    import noiseandheat.games.playingflash.worlds.GameWorld;
    import flash.display.Sprite;
    import flash.geom.Point;


    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class Entity extends Sprite
    {
        public var next:Entity;
        public var prev:Entity;
        public var head:Entity;

        public var app:Application;
        public var world:GameWorld;

        protected var _point:Point = new Point();

        public function init():void
        {

        }

        public function update():void
        {

        }

        public function collide(x:Number, y:Number):Entity
        {
            _point.x = x;
            _point.y = y;

            _point = localToGlobal(_point);

            var cur:Entity = head;
            while(cur)
            {
                var r:Rectangle = cur.getBounds(stage);
                if(r.containsPoint(_point))
                {
                    return cur;
                }
                cur = cur.next;
            }

            return null;
        }

        public function distanceToPoint(px:Number, py:Number):Number
        {
            return Math.sqrt((x - px) * (x - px) + (y - py) * (y - py));
        }

        public function moveTo(x:Number, y:Number):void
        {
            this.x = x;
            this.y = y;
        }

        public function moveTowards(x:Number, y:Number, amount:Number):void
        {
            _point.x = x - this.x;
            _point.y = y - this.y;

            _point.normalize(amount);

            moveTo(this.x + _point.x, this.y + _point.y);
        }
    }
}

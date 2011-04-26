package noiseandheat.games.playingflash.entities
{
    import noiseandheat.games.playingflash.assets.R;

    import flash.display.DisplayObject;

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class PlayerEntity extends Entity
    {
        protected static const JITTER:int = 33;
        protected static const HALF_JITTER:int = JITTER/2;

        protected var jitterX:int;
        protected var jitterY:int;
        protected var jitterUpdate:int;

        protected var targetX:int;
        protected var targetY:int;

        public function PlayerEntity()
        {
            var image:DisplayObject = DisplayObject(new R.player_png());
            image.x = -21;
            image.y = -10;
            addChild(image);

            targetX = this.x;
            targetY = this.y;
        }

        override public function update():void
        {
            if(app.mouseDown)
            {
                targetX = app.mouseX;
                targetY = app.mouseY;
            }

            if(app.mouseReleased)
            {
                targetX = x;
                targetY = y;
            }

            if(--jitterUpdate <= 0)
            {
                jitterX = app.rand(JITTER) - HALF_JITTER;
                jitterY = app.rand(JITTER) - HALF_JITTER;
                jitterUpdate = app.rand(app.framerate / 3) + app.framerate / 3;
            }

            var tX:int = targetX + jitterX;
            var tY:int = targetY + jitterY;
            var distance:Number = distanceToPoint(tX, tY);
            var v:Number = distance * 0.1;

            moveTowards(tX, tY, v);

            var t:TargetEntity = collide(x, y) as TargetEntity;
            if(t) t.spawn();
        }
    }
}

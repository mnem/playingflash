package noiseandheat.games.playingflash.entities
{

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class FramerateVisualiserEntity extends Entity
    {
        protected const SIZE:int = 8;
        protected var RESOLUTION:int = 30;

        protected var blips:Vector.<Image>;

        public function FramerateVisualiserEntity()
        {
            blips = new Vector.<Image>();
        }

        override public function init():void
        {
            RESOLUTION = app.framerate;

            var img:Image;
            for(var i:int = 0; i < RESOLUTION; i++)
            {
                if(i % 5 == 0)
                {
                    img = Image.createRect(SIZE, i % 10 == 0? SIZE * 1.5 : SIZE, app.colorLerp(0xff0000, 0x00ff00, i/RESOLUTION));
                }
                else
                {
                    img = Image.createCircle(SIZE/2, app.colorLerp(0xff0000, 0x00ff00, i/RESOLUTION));
                }

                img.x = SIZE * i;
                blips.push(img);
                addChild(img);
                img.init();
            }
        }

        override public function update():void
        {
            var blipCount:int;

            if(!isNaN(app.actualFramerate))
            {
                var normalised:Number = app.actualFramerate / app.framerate;
                blipCount = app.clamp(Math.round(blips.length * normalised), 0, blips.length - 1);
            }

            for(var blip:int = 0; blip < blips.length; blip++)
            {
                if(blip <= blipCount)
                {
                    blips[blip].visible = true;
                }
                else
                {
                    blips[blip].visible = false;
                }
            }
        }
    }
}

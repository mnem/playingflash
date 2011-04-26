package noiseandheat.games.playingflash.entities
{

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class TargetEntity extends Entity
    {
        protected const MAX_PARTICLES:int = 200;

        public function TargetEntity()
        {
            addChild(Image.createCircle(25, 0xffffff));
        }

        override public function init():void
        {
            spawn();
        }

        public function spawn():void
        {
            moveTo(app.rand(app.width - 20) + 10, app.rand(app.height - 20) + 10);
        }

        override public function update():void
        {
//            if(stoke)
//            {
//                e.emit("flurry", 0, 0);
//                if(e.particleCount >= MAX_PARTICLES)
//                {
//                    stoke = false;
//                }
//            }
//            else if(e.particleCount < MIN_PARTICLES)
//            {
//                stoke = true;
//            }
        }
    }
}

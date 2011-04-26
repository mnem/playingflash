package noiseandheat.games.playingflash.entities
{
    import pman.P;
    import pman.PMan;
    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class TargetEntity extends Entity
    {
        protected const MAX_PARTICLES:int = 200;
        protected var COLOURS:Vector.<int> = Vector.<int>([0xFFFFFF, 0xFFEA47, 0xFFB921, 0x2B777F, 0x151836]);

        protected var particles:PMan = new PMan(64, 64);

        public function TargetEntity()
        {
            createParticles();
            addChild(particles);
            type = "target";
        }

        protected function createParticles():void
        {
            particles = new PMan(64, 64, null, 0xff000000);
            particles.addEmitter(MAX_PARTICLES, 32, 32, COLOURS, false, P.GFX_POINT);
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
            particles.update();
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

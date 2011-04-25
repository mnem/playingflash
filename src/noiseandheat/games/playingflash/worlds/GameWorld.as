package noiseandheat.games.playingflash.worlds
{
    import noiseandheat.games.PlayingFlashApp;
    import noiseandheat.games.playingflash.entities.Entity;
    import noiseandheat.games.playingflash.entities.FramerateVisualiserEntity;
    import noiseandheat.games.playingflash.entities.PlayerEntity;

    import flash.display.Sprite;

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class GameWorld
        extends Sprite
    {
        protected var entities:Vector.<Entity>;

        public var app:PlayingFlashApp;

        public function GameWorld()
        {
            entities = new Vector.<Entity>();
        }

        public function activate():void
        {
            add(new FramerateVisualiserEntity());
            add(new PlayerEntity());
        }

        public function add(entity:Entity):void
        {
            entity.app = app;
            entity.world = this;
            entities.push(entity);
            addChild(entity);
            entity.init();
        }

        public function update():void
        {
            for(var i:int=0; i < entities.length; i++)
            {
                entities[i].update();
            }
        }
    }
}

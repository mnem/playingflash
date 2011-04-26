package noiseandheat.games.playingflash.worlds
{
    import noiseandheat.games.playingflash.Application;
    import noiseandheat.games.playingflash.entities.Entity;
    import noiseandheat.games.playingflash.entities.FramerateVisualiserEntity;
    import noiseandheat.games.playingflash.entities.PlayerEntity;
    import noiseandheat.games.playingflash.entities.TargetEntity;

    import flash.display.Sprite;


    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class GameWorld
        extends Sprite
    {
        protected var entities:Vector.<Entity>;

        public var app:Application;

        public function GameWorld()
        {
            entities = new Vector.<Entity>();
        }

        public function activate():void
        {
            add(new FramerateVisualiserEntity());
            add(new PlayerEntity());
            add(new TargetEntity());
        }

        public function add(entity:Entity):void
        {
            entity.app = app;
            entity.world = this;

            var prev:Entity;
            if(entities.length > 0) prev = entities[entities.length - 1];

            entities.push(entity);

            entity.prev = prev;
            if(prev) prev.next = entity;
            entity.head = entities[0];

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

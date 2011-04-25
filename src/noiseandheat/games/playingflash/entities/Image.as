package noiseandheat.games.playingflash.entities
{

    /**
     * Copyright (c) 2011 HuzuTech
     */
    public class Image
        extends Entity
    {
        public static function createRect(w:int, h:int, c:uint):Image
        {
            var img:Image = new Image();

            img.graphics.beginFill(c & 0xffffff, 1.0/*(c >> 24) / 255.0*/);
            img.graphics.drawRect(0, 0, w, h);
            img.graphics.endFill();

            return img;
        }

        public static function createCircle(r:int, c:uint):Image
        {
            var img:Image = new Image();

            img.graphics.beginFill(c & 0xffffff, 1.0/*(c >> 24) / 255.0*/);
            img.graphics.drawCircle(r, r, r);
            img.graphics.endFill();

            return img;
        }
    }
}

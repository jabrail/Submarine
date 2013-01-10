package MVCLevel
{
	import flash.display.Sprite;

	public class Camera extends Sprite
	{

		public function Camera(width : Number, height : Number)
		{
			this.graphics.beginFill(0x000000,0);
			this.graphics.drawRect(0,0,width,height);
			
			
		}
		public function visArray(arrayVisible : Array) : void
		{
			for (var i : Number= 0; i<arrayVisible.length;i++)
			{
				if (this.hitTestObject(arrayVisible[i]))
				{
					arrayVisible[i].visible = true;
				}
				else
				{
					arrayVisible[i].visible = false;
				}
			}
		}
		
	}
}
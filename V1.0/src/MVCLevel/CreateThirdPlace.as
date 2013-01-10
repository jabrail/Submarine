package MVCLevel
{
	import flash.display.Bitmap;

	public class CreateThirdPlace
	{
		[Embed(source="../images/ThirdPlace/1.png")]
		private var ThirdPlaceCenter1:Class;
		[Embed(source="../images/ThirdPlace/2.png")]
		private var ThirdPlaceCenter2:Class;
		[Embed(source="../images/ThirdPlace/3.png")]
		private var ThirdPlaceCenter3:Class;
		[Embed(source="../images/ThirdPlace/4.png")]
		private var ThirdPlaceCenter4:Class;
		[Embed(source="../images/ThirdPlace/5.png")]
		private var ThirdPlaceCenter5:Class;
		[Embed(source="../images/ThirdPlace/6.png")]
		private var ThirdPlaceCenter6:Class;
		[Embed(source="../images/ThirdPlace/7.png")]
		private var ThirdPlaceCenter7:Class;
		[Embed(source="../images/ThirdPlace/8.png")]
		private var ThirdPlaceCenter8:Class;
		[Embed(source="../images/ThirdPlace/1/1.png")]
		private var ThirdPlaceFinish1:Class;
		[Embed(source="../images/ThirdPlace/1/2.png")]
		private var ThirdPlaceFinish2:Class;
		[Embed(source="../images/ThirdPlace/1/3.png")]
		private var ThirdPlaceFinish3:Class;
		[Embed(source="../images/ThirdPlace/1/4.png")]
		private var ThirdPlaceFinish4:Class;
		[Embed(source="../images/ThirdPlace/1/5.png")]
		private var ThirdPlaceFinish5:Class;
		[Embed(source="../images/ThirdPlace/1/6.png")]
		private var ThirdPlaceFinish6:Class;
		[Embed(source="../images/ThirdPlace/1/7.png")]
		private var ThirdPlaceFinish7:Class;
		[Embed(source="../images/ThirdPlace/2/2.png")]
		private var ThirdPlaceStart1:Class;
		[Embed(source="../images/ThirdPlace/2/2.png")]
		private var ThirdPlaceStart2:Class;
		public var arrayThirdPlaceCenter: Array = new Array();
		public var arrayThirdPlaceStart: Array = new Array();
		public var arrayThirdPlaceFinish: Array = new Array();

	
		
		public function CreateThirdPlace()
		{
		
			
			
			
		}
		public function thirdPlaceCenter(index : int) : Class
		{
			if (index==0) return(ThirdPlaceCenter1)
			else if (index==1) return(ThirdPlaceCenter2)
			else if (index==2) return(ThirdPlaceCenter3)
			else if (index==3) return(ThirdPlaceCenter4)
			else if (index==4) return(ThirdPlaceCenter5)
			else if (index==5) return(ThirdPlaceCenter6)
			else if (index==6) return(ThirdPlaceCenter7)
			else if (index==7) return(ThirdPlaceCenter8)
			else return(ThirdPlaceCenter8);
		}
		public function thirdPlaceFinish(index : int) : Class
		{
			if (index==0) return(ThirdPlaceFinish1)
			else if (index==1) return(ThirdPlaceFinish2)
			else if (index==2) return(ThirdPlaceFinish3)
			else if (index==3) return(ThirdPlaceFinish4)
			else if (index==4) return(ThirdPlaceFinish5)
			else if (index==5) return(ThirdPlaceFinish6)
			else if (index==6) return(ThirdPlaceFinish7)
			else return(ThirdPlaceFinish7);
		}
		public function thirdPlaceStart(index : int) : Class
		{
			if (index==0) return(ThirdPlaceStart1)
			else if (index==1) return(ThirdPlaceStart2)
			else return(ThirdPlaceStart2);
		}
	}
}
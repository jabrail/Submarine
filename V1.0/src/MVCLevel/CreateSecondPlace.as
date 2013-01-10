package MVCLevel
{
	public class CreateSecondPlace
	{
		[Embed(source="../images/secondPlace/0.png")]
		private var SecondPlace0:Class;
		[Embed(source="../images/secondPlace/1.png")]
		private var SecondPlace1:Class;
		[Embed(source="../images/secondPlace/2.png")]
		private var SecondPlace2:Class;
		[Embed(source="../images/secondPlace/3.png")]
		private var SecondPlace3:Class;
		[Embed(source="../images/secondPlace/4.png")]
		private var SecondPlace4:Class;
		[Embed(source="../images/secondPlace/5.png")]
		private var SecondPlace5:Class;
		[Embed(source="../images/secondPlace/6.png")]
		private var SecondPlace6:Class;
		[Embed(source="../images/secondPlace/7.png")]
		private var SecondPlace7:Class;
		[Embed(source="../images/secondPlace/8.png")]
		private var SecondPlace8:Class;
		[Embed(source="../images/secondPlace/9.png")]
		private var SecondPlace9:Class;
		[Embed(source="../images/secondPlace/10.png")]
		private var SecondPlace10:Class;		
		[Embed(source="../images/secondPlace/11.png")]
		private var SecondPlace11:Class;
		[Embed(source="../images/secondPlace/12.png")]
		private var SecondPlace12:Class;
		[Embed(source="../images/secondPlace/13.png")]
		private var SecondPlace13:Class;
		[Embed(source="../images/secondPlace/14.png")]
		private var SecondPlace14:Class;
		[Embed(source="../images/secondPlace/15.png")]
		private var SecondPlace15:Class;
		[Embed(source="../images/secondPlace/16.png")]
		private var SecondPlace16:Class;		
		[Embed(source="../images/secondPlace/17.png")]
		private var SecondPlace17:Class;
		[Embed(source="../images/secondPlace/18.png")]
		private var SecondPlace18:Class;
		[Embed(source="../images/secondPlace/19.png")]
		private var SecondPlace19:Class;
		[Embed(source="../images/secondPlace/20.png")]
		private var SecondPlace20:Class;

		public function CreateSecondPlace()
		{
			
		}
		public function returnSecondPlace(index : int) : Class
		{
			if (index==0) return(SecondPlace0)
			else if (index==1) return(SecondPlace1)
			else if (index==2) return(SecondPlace2)
			else if (index==3) return(SecondPlace3)
			else if (index==4) return(SecondPlace4)
			else if (index==5) return(SecondPlace5)
			else if (index==6) return(SecondPlace6)
			else if (index==7) return(SecondPlace7)
			else if (index==8) return(SecondPlace8)				
			else if (index==9) return(SecondPlace9)
			else if (index==10) return(SecondPlace10)
			else if (index==11) return(SecondPlace11)
			else if (index==12) return(SecondPlace12)
			else if (index==13) return(SecondPlace13)
			else if (index==14) return(SecondPlace14)
			else if (index==15) return(SecondPlace15)
			else if (index==16) return(SecondPlace16)
			else if (index==17) return(SecondPlace17)
			else if (index==18) return(SecondPlace18)
			else if (index==19) return(SecondPlace19)
			else if (index==20) return(SecondPlace20)
			else return(SecondPlace20);
				
		}
	}
}
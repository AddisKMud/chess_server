package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent
	
	
	public class hello extends MovieClip {
		
		
		public function hello() {
			// constructor code
			btn.addEventListener(MouseEvent.CLICK,onclick);
		}
		
		private function onclick(me){
			trace("hello world");
		}
	}
	
}

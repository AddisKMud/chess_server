package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Login extends MovieClip {
		
		
		public function Login() {
			// constructor code
			btn_login.addEventListener(MouseEvent.CLICK,onLogin);
			btn_register.addEventListener(MouseEvent.CLICK,onRegister);
		}
		
		private function onLogin(e){
			trace("onLogin");
		}
		
		private function onRegister(e){
			trace("onRegister");
		}
	}
	
}

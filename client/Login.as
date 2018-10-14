package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import com.adobe.serialization.json.JSON;


	
	public class Login extends MovieClip {
		
		
		public function Login() {
			// constructor code
			btn_login.addEventListener(MouseEvent.CLICK,onLogin);
			btn_register.addEventListener(MouseEvent.CLICK,onRegister);
		}
		
		private function onLogin(e){
			trace("onLogin");
			
			var o = {
				"account": input_account.text,
				"password":input_password.text
			};
			var jsonString:String = com.adobe.serialization.json.JSON.encode(o);
 
   		var urlVariables:URLVariables = new URLVariables();
    		urlVariables.json = jsonString;
 
   		var urlRequest:URLRequest = new URLRequest("http://222.73.139.48:6000/login"); //这里是接收数据的动态页。
    		urlRequest.method = URLRequestMethod.POST;
    		urlRequest.data = jsonString;
 
   		//其实到这已经结束了，下面的XML只是测试结果而已。
    		var urlLoader:URLLoader = new URLLoader();
    		urlLoader.addEventListener(Event.COMPLETE, onURLLoaderCompleteEvent);
   		urlLoader.load(urlRequest);
		}
		
		private function onRegister(e){
			trace("onRegister");
		}
		
		private function onURLLoaderCompleteEvent(e){

		}
	}
	
}

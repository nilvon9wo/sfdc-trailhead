public class TH_HypotheticalCalloutService { 
	@future(callout=true)
	public static void makeCallout() {
		HttpRequest request = new HttpRequest();
		request.setEndPoint('http://your-host.example.com/your-service');
		request.setMethod('GET');
		HttpResponse response = new Http().send(request);
	}
}
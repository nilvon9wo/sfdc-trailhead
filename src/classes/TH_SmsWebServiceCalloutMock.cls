@isTest
global class TH_SmsWebServiceCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request) {
    	HttpResponse response = new HttpResponse();
    	response.setHeader('Content-Type', 'application/json');
    	response.setBody('{"status":"success"}');
    	response.setStatusCode(200);
    	return response;
    }
}
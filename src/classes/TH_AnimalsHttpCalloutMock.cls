@isTest
global class TH_AnimalsHttpCalloutMock implements HttpCalloutMock {
	String contentTypeName;
	String contentTypeValue;
	String responseBody;
	String expectedRequestBody;
	
	public TH_AnimalsHttpCalloutMock(String expectedRequestBody, String contentTypeName, String contentTypeValue, String responseBody) {
		this.contentTypeName = contentTypeName;
		this.contentTypeValue = contentTypeValue;
		this.responseBody = responseBody;
		this.expectedRequestBody = expectedRequestBody;
	}
	
	global HTTPResponse respond(HTTPRequest request) {
		System.assertEquals(expectedRequestBody, request.getBody());
		
		HttpResponse response = new HttpResponse();
		response.setHeader(this.contentTypeName, this.contentTypeValue);
		response.setBody(this.responseBody);
		response.setStatusCode(200);
		return response; 
	}
}
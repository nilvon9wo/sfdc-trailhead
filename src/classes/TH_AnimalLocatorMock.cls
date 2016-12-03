@isTest
global class TH_AnimalLocatorMock implements HttpCalloutMock {
	String animalName;
	Boolean goodRequest;
	
	public TH_AnimalLocatorMock(String animalName, Boolean goodRequest) {
		this.animalName = animalName;
		this.goodRequest = goodRequest;
	}

	public TH_AnimalLocatorMock(String animalName) {
		this(animalName, true);
	}
	
	global HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
		if (this.goodRequest) {
			response.setBody('{"animal":{"id":1,"name":"'+animalName+'","eats":"chicken food","says":"cluck cluck"}}');
			response.setStatusCode(200);
		}
		else {
			response.setStatusCode(500);
		}
		return response; 
	}
}
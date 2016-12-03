public class TH_AnimalLocatorStrategy extends TH_AnimalsRestfulCalloutStrategy {
	public TH_Animal animal {get; private set;}	
	
	public override HttpResponse onSuccess(HttpResponse response) {
		String responseBody = response.getBody();
		JSONParser parser = JSON.createParser(responseBody);
		while(parser.nextToken() != null) {
			while (parser.nextToken() != null) {
				if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
					this.animal = (TH_Animal) parser.readValueAs(TH_Animal.class);
					parser.skipChildren();
				}
			}
		}
		return response;
	}
}  
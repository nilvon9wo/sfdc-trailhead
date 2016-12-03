public class TH_AnimalsRestfulCalloutService {
	public HttpResponse getAnimals() {
		TH_AnimalsRestfulCalloutStrategy callout = new TH_AnimalsRestfulCalloutStrategy();
		return callout.execute(); 
	} 
	
	public HttpResponse postAnimal(String animal) {
		TH_AnimalsRestfulCalloutStrategy callout = new TH_AnimalsRestfulCalloutStrategy();
		callout.method = 'POST';
		callout.contentType = 'application/json;charset=UTF-8';
		callout.createBody(animal);
		callout.successCodeSet = new Set<Integer>{ 201 };
		return callout.execute(); 
	} 
}
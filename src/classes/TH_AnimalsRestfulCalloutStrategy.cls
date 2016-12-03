public virtual class TH_AnimalsRestfulCalloutStrategy extends HTTP_RestfulCalloutStrategy {
	 
	public TH_AnimalsRestfulCalloutStrategy() {
		super('https://th-apex-http-callout.herokuapp.com/animals');
	}
	
	public virtual override HttpResponse onSuccess(HttpResponse response) {
		Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		List<Object> animalList = (List<Object>) results.get('animals');
		this.log(animalList);
		return response;
	}     

	private void log (List<Object> animalList) {
		this.logger.info('Received the following animals:');
		for (Object animal : animalList) {
			this.logger.info((String) animal); 
		}
	}
	
	public String createBody(String animal) {
		String body = '{"name": "' + animal + '"}';
		this.body = body;
		return body;
	}
}
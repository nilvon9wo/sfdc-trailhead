public abstract class HTTP_RestfulCalloutStrategy implements HTTP_RestfulCalloutStrategyInterface {
	protected LOG_Logger logger;
	private String endpoint; 
	public Integer targetId {get; set;}
	public String method {get; set;}
	public String contentType {get; set;}
	public String body {get; set;}
	public Set<Integer> successCodeSet = new Set<Integer>{ 200 }; 
	
	public HTTP_RestfulCalloutStrategy(String endpoint, LOG_Logger logger){
		this.endpoint = endpoint;
		this.logger = logger; 
	}
	
	public HTTP_RestfulCalloutStrategy(String endpoint){
		this(endpoint, new LOG_Logger());
	}
	
	public HttpResponse execute() { 
		Http http = new Http();
		
		HttpRequest request = new HttpRequest();
		configureRequest(request);
		HttpResponse response = http.send(request);
		
		if (!(this.successCodeSet.contains(response.getStatusCode()))) {
			return onFailure(response);
		} 
		else {
			return onSuccess(response);
		}
	}    
	 	
	private HttpRequest configureRequest(HttpRequest request) {
		String endpoint = this.endpoint;
		if (targetId != null) {
			endpoint += '/' + targetId;
		}
		request.setEndpoint(endpoint);

		String method = (!String.isBlank(this.method)) ? this.method : 'GET'; 
		request.setMethod(method);

		if (!String.isBlank(this.contentType)){
			request.setHeader('Content-Type', this.contentType);
		}

		if (!String.isBlank(this.body)){
			request.setBody(this.body);
		}
		return request;
	} 	
	 	
	 	
	public abstract HttpResponse onSuccess(HttpResponse response);
	 	
	public virtual HttpResponse onFailure(HttpResponse response) {
		logger.error('Unexpected Response: ' + response.toString());
		return response;
	}
}
public interface HTTP_RestfulCalloutStrategyInterface {
	HttpResponse onSuccess(HttpResponse response);
	HttpResponse onFailure(HttpResponse response);
}
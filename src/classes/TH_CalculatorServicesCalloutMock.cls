@isTest
global class TH_CalculatorServicesCalloutMock implements WebServiceMock {
	global void doInvoke(
		Object stub,
		Object request,
		Map<String, Object> response,
		String endpoint,
		String soapAction,
		String requestName,
		String responseNS,
		String responseName,
		String responseType
	) {
		TH_CalculatorServices.doAddResponse response_x = new TH_CalculatorServices.doAddResponse();
		response_x.return_x = 3.0;
		response.put('response_x', response_x);
	}
}
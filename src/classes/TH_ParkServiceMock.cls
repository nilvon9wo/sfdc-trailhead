@isTest
global class TH_ParkServiceMock implements WebServiceMock {
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
		TH_ParkService.byCountryResponse response_x = new TH_ParkService.byCountryResponse();
		response_x.return_x = new List<String>{
			'Yellowstone', 'Mackinac National Park', 'Yosemite'
		};
		response.put('response_x', response_x);
	}
}
@isTest
private class TH_AnimalsRestfulCalloutServiceTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Integer expectedStatusCode = 200;
	private static final String expectedHeaderName = 'Content-Type';  
	private static final String expectedHeaderValue = 'application/json;charset=UTF-8';  

	@isTest static void testGetAnimalsShouldFetchAnimals(){
		// Arrange
		TH_AnimalsRestfulCalloutService serviceUnderTest = new TH_AnimalsRestfulCalloutService();
		StaticResourceCalloutMock mock = createGetMethodMock();
		
		// Act
		HttpResponse result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = serviceUnderTest.getAnimals();
            } 
            Test.stopTest();
        }

		// Assert
		System.assertNotEquals(null, result, 'The callout returned a null response.');
		assertStatus(result);
		assertContentType(result);
		assertGetResponseBody(result);
	}
	
	private static StaticResourceCalloutMock createGetMethodMock () {
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource('GetAnimalResource');
		mock.setStatusCode(expectedStatusCode);
		mock.setHeader(expectedHeaderName, expectedHeaderValue);
		Test.setMock(HttpCalloutMock.class, mock);
		return mock;
	} 
	
	private static void assertGetResponseBody(HttpResponse result) {
		Map<String, Object> resultMap = (Map<String,Object>) JSON.deserializeUntyped(result.getBody());
		List<Object> animalList = (List<Object>) resultMap.get('animals');
		System.assertEquals(3, animalList.size(), 'The list should only contain 3 items.');
	}	
	
	// ----------------------------------------------------------------------------------------
	
	@isTest static void testPostAnimalShouldSendAnimal(){
		// Arrange
		TH_AnimalsRestfulCalloutService serviceUnderTest = new TH_AnimalsRestfulCalloutService();
		
		String testAnimal = 'Elephant';
		String expectedBody = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
		TH_AnimalsHttpCalloutMock calloutMock = createPostMethodMock (testAnimal, expectedBody);
		
		// Act
		HttpResponse result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = serviceUnderTest.postAnimal(testAnimal);
            }
            Test.stopTest();
        }

		// Assert
		System.assertNotEquals(null, result, 'The callout returned a null response.');
		assertStatus(result);
		assertContentType(result);
		assertPostResponseBody(result, expectedBody);
	}
	
	private static TH_AnimalsHttpCalloutMock createPostMethodMock (String testAnimal, String expectedResponseBody) {
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		String expectedRequestBody = '{"name": "' + testAnimal + '"}';
		
		TH_AnimalsHttpCalloutMock calloutMock = new TH_AnimalsHttpCalloutMock(
			expectedRequestBody,
			expectedHeaderName, 
			expectedHeaderValue, 
			expectedResponseBody
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);
		return calloutMock;
	} 
	
	private static void assertPostResponseBody(HttpResponse result, String expectedBody) {
		String resultBody = result.getBody();
		System.assertEquals(
			expectedBody, 
			resultBody, 
			'The body is ' + resultBody + ' instead of ' + expectedBody + '.'
		);
	}	
	
	// ----------------------------------------------------------------------------------------

	private static void assertStatus(HttpResponse result){
		Integer resultStatusCode = result.getStatusCode();
		System.assertEquals(
			expectedStatusCode, 
			resultStatusCode, 
			'The status code is ' + resultStatusCode + ' instead of ' + expectedStatusCode + '.'
		);
	}
	
	private static void assertContentType(HttpResponse result) {
		String resultHeaderValue = result.getHeader(expectedHeaderName);
		System.assertEquals(
			expectedHeaderValue, 
			resultHeaderValue, 
			'The content type value is ' + resultHeaderValue + ' instead of ' + expectedHeaderValue + '.'
		);
	}
}
@isTest
private class TH_CaseManagerRestResourceTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create();
	private static final String baseUri = 'https://eu11.salesforce.com/services/apexrest/Cases/'; 
	
	private static final String testSubject = 'Ferocious chipmunk';
	private static final String testOrigin = 'Phone';
	private static final String testPriority = 'Low';
	
	@isTest static void testGetCaseById(){
		// Arrange
		Id testCaseId = createTest(testSubject);
		RestRequest request = new RestRequest();
		request.requestUri = baseUri + testCaseId;
		request.httpMethod = 'GET';
		RestContext.request = request;

		// Act
		Case result;
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		result = TH_CaseManagerRestResource.getCaseById(); 
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(testSubject, result.subject);
	}

	@isTest static void testCreateCase(){
		// Arrange
		String testStatus = 'New';

		// Act
		Id resultId;
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		resultId = TH_CaseManagerRestResource.createCase(testSubject, testStatus, testOrigin, testPriority); 
            }
            Test.stopTest();
        }

		// Assert
		assertExpectedCase(resultId, testSubject, testStatus);
	}
	
	@isTest static void testDeleteCase(){
		// Arrange
		Id testCaseId = createTest();
		RestRequest request = new RestRequest();
		request.requestUri = baseUri + testCaseId;
		request.httpMethod = 'GET';
		RestContext.request = request;
		

		// Act
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		TH_CaseManagerRestResource.deleteCase(); 
            }
            Test.stopTest();
        }

		// Assert
		List<Case> resultCaseList = [SELECT id, subject FROM Case WHERE id = :testCaseId];
		System.assertEquals(0, resultCaseList.size());
	}

	@isTest static void testUpsertCaseWithoutId(){
		// Arrange
		String testStatus = 'New';

		// Act
		Id resultId;
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		resultId = TH_CaseManagerRestResource.upsertCase(testSubject, testStatus, testOrigin, testPriority, null); 
            }
            Test.stopTest();
        }

		// Assert
		assertExpectedCase(resultId, testSubject, testStatus);
	}

	@isTest static void testUpsertCaseWithId(){
		// Arrange
		Id testCaseId = createTest();
		String testStatus = 'Working';

		// Act
		Id resultId;
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		resultId = TH_CaseManagerRestResource.upsertCase(testSubject, testStatus, testOrigin, testPriority, testCaseId); 
            }
            Test.stopTest();
        }

		// Assert
		assertExpectedCase(resultId, testSubject, testStatus);
	}

	@isTest static void testUpdateCaseFields(){
		// Arrange
		Id testCaseId = createTest(testSubject);

		RestRequest request = new RestRequest();
		request.requestUri = baseUri + testCaseId;
		request.httpMethod = 'PATCH';
		request.addHeader('Content-Type', 'application/json');
		String testStatus = 'Working';
		request.requestBody = Blob.valueOf('{"status":"'+testStatus+'"}');
		RestContext.request = request;

		// Act
		Id resultId;
        System.runAs(TestRunner){  
            Test.startTest();
            {
           		resultId = TH_CaseManagerRestResource.updateCaseFields(); 
            }
            Test.stopTest();
        }

		// Assert
		assertExpectedCase(resultId, testSubject, testStatus);
	}
 
	// --------------------------------------------------------------------------------------
	
	private static Id createTest(String subject){
		return MOCK_CaseFactory.create(subject, TEST_DummyInsertModeEnum.REAL).id;
	}

	private static Id createTest(){
		return MOCK_CaseFactory.create(TEST_DummyInsertModeEnum.REAL).id;
	}

	private static void assertExpectedCase(Id resultId, String expectedSubject, String expectedStatus) {
		System.assert(resultId != null);
		Case resultCase = [SELECT id, subject FROM Case WHERE id = :resultId];
		System.assert(resultCase != null);
		System.assertEquals(testSubject, resultCase.subject);
	}

}
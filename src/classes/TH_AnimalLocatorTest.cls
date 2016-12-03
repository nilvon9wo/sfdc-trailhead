@isTest
private class TH_AnimalLocatorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Integer testId = 1;
	private static final String expectedAnimal = 'chicken';
	private static final Integer expectedStatusCode = 200;
	private static final String expectedHeaderName = 'Content-Type';  
	private static final String expectedHeaderValue = 'application/json;charset=UTF-8';
	private static final Boolean BAD_REQUEST = false;  
	
	@isTest static void testGetAnimalNameByIdShouldReturnAnimalName(){
		// Arrange
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		Test.setMock(HttpCalloutMock.class, new TH_AnimalLocatorMock(expectedAnimal));
		
		// Act
		String result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_AnimalLocator.getAnimalNameById(testId);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, expectedAnimal);
	}

	@isTest static void testGetNameByIdShouldReturnAnimalName(){
		// Arrange
		TH_AnimalLocator serviceUnderTest = new TH_AnimalLocator();
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		Test.setMock(HttpCalloutMock.class, new TH_AnimalLocatorMock(expectedAnimal));
		
		// Act
		String result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = serviceUnderTest.getNameById(testId);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, expectedAnimal);
	}
	
	@isTest static void testGetNameByIdShouldNullIfTheRequestIsUnsuccessful(){
		// Arrange
		TH_AnimalLocator serviceUnderTest = new TH_AnimalLocator();
		
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		Test.setMock(HttpCalloutMock.class, new TH_AnimalLocatorMock(expectedAnimal, BAD_REQUEST));
		
		// Act
		String result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = serviceUnderTest.getNameById(testId);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, null);
	}
}
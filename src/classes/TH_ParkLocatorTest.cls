@isTest
private class TH_ParkLocatorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void countryShouldReturnExpectedNumberOfParks(){
		// Arrange
		Test.setMock(WebServiceMock.class, new TH_ParkServiceMock());
		String testCountry = 'Germany';
		 
		// Act
		List<String> result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_ParkLocator.country(testCountry);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(3.0, result.size());
	}

	@isTest static void byCountryShouldReturnExpectedNumberOfParks(){
		// Arrange
		Test.setMock(WebServiceMock.class, new TH_ParkServiceMock());
		TH_ParkLocator locatorUnderTest = new TH_ParkLocator();
		String testCountry = 'Germany';
		
		// Act
		List<String> result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = locatorUnderTest.byCountry(testCountry);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(3.0, result.size());
	}
}
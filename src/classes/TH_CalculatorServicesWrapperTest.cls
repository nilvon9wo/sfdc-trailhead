@isTest
private class TH_CalculatorServicesWrapperTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void addShouldReturnTheExpectedSum(){
		// Arrange
		Test.setMock(WebServiceMock.class, new TH_CalculatorServicesCalloutMock());
		Double testValue1 = 1.0;
		Double testValue2 = 2.0;
		
		// Act
		Double result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_CalculatorServicesWrapper.add(testValue1, testValue2);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(3.0, result);
	}
}
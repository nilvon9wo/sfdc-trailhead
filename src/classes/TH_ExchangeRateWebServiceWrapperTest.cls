@isTest
private class TH_ExchangeRateWebServiceWrapperTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void getParseValuesShouldParseValuesGeneratedByGetLoadRate(){
		// Arrange
		// TO DO: arrange unit test
		TH_ExchangeRateWebServiceWrapper targetClass = new TH_ExchangeRateWebServiceWrapper();

		// NOTE: This is a shitty test, created for debugging. 
		// Do NOT test like this for production code.
		String testLoadRates = 'EUR>EUR:1;EUR>GBP:0.84;EUR>CAD:1.42;EUR>PLN:4.48;EUR>INR:72.54;EUR>AUD:1.43'; 
		
		// Act
		Map<String, List<ExchangeRate__c>> result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = targetClass.getParseValues(testLoadRates);
            }
            Test.stopTest();
        }

		// Assert
		// TO DO: assert results
		System.assert(result != null);
		System.assert(result.size() == 6);
	}
}
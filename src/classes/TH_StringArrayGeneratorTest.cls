@isTest
private class TH_StringArrayGeneratorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static testMethod void generateStringArrayShouldGenerate0Strings(){
		testGenerateStringArray(0);
	}

	private static testMethod void generateStringArrayShouldGenerate1Strings(){
		testGenerateStringArray(1);
	}

	private static testMethod void generateStringArrayShouldGenerate2Strings(){
		testGenerateStringArray(2);
	}

	private static void testGenerateStringArray(Integer quantity){
		// Arrange
		// Nothing to do here
		
		// Act
		List<String> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = TH_StringArrayGenerator.generateStringArray(quantity);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(resultList.size(), quantity);
	}
}
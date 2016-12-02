@isTest
private class TH_TaskUtilTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testGetPriority(){
		// Arrange
		String input = 'CA';
		
		// Act
		String result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_TaskUtil.getTaskPriority(input);
            }
            Test.stopTest();
        }

		// Assert
		String expectedResult = 'High';
		System.assertEquals(result, expectedResult);
	}

	@isTest static void getPriorityShouldReturnNullWhenInputIsNull(){
		testGetPriority(null, null);
	}

	@isTest static void getPriorityShouldReturnNullWhenInputIsEmpty(){
		testGetPriority('', null);
	}

	@isTest static void getPriorityShouldReturnHighWhenInputIsCA(){
		testGetPriority('CA', 'High');
	}

	@isTest static void getPriorityShouldReturnNullWhenInputIsBlank(){
		testGetPriority('NY', 'Normal');
	}

	@isTest static void getPriorityShouldReturnNullWhenInputIsLong(){
		testGetPriority('Montana', null);
	}

	private static void testGetPriority(String input, String expectedResult){
		// Arrange
		TH_TaskUtil utilUnderTest = new TH_TaskUtil();
		
		// Act
		String result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = utilUnderTest.getPriority(input);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, expectedResult);
	}
}
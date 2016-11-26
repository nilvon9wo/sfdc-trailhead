@isTest
private class TH_AccountFactoryTest { 
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final String expectedName = 'Acme';
	private static final String expectedPhone = '(415) 555-1212';
	private static final Integer expectedEmployeeCount = 100;
	
	private static testMethod void createShouldCreateSpecifiedAccount(){
		// Arrange
		TH_AccountFactory accountGenerator = new TH_AccountFactory();
		
		// Act
		Account result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = accountGenerator.create(expectedName);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result.name, expectedName);
	}

	private static testMethod void createShouldIncludeDetailsWhenCreatingSpecifiedAccount(){
		// Arrange
		TH_AccountFactory accountGenerator = new TH_AccountFactory();
		
		// Act
		Account result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = accountGenerator.create(expectedName, expectedPhone, expectedEmployeeCount);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result.name, expectedName);
		System.assertEquals(result.phone, expectedPhone);
		System.assertEquals(result.numberOfEmployees, expectedEmployeeCount);
	}

}
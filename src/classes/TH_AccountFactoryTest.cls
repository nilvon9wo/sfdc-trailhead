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
		System.assertEquals(result.id, null);
		System.assertEquals(result.name, expectedName);
		System.assertEquals(result.phone, null);
		System.assertEquals(result.numberOfEmployees, null);
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
		System.assertEquals(result.id, null);
		System.assertEquals(result.name, expectedName);
		System.assertEquals(result.phone, expectedPhone);
		System.assertEquals(result.numberOfEmployees, expectedEmployeeCount);
	}

	private static testMethod void createShouldInsertWithDetailsWhenCreatingSpecifiedAccount(){
		// Arrange
		DAO_AccountDao mockAccountDao = new MOCK_AccountDao();
		MOCK_AccountDao.insertedAccount = false; 
		TH_AccountFactory accountGenerator = new TH_AccountFactory(mockAccountDao);
		
		// Act
		Account result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = accountGenerator.create(expectedName, expectedPhone, expectedEmployeeCount, DAO_Timing.NOW);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(MOCK_AccountDao.insertedAccount);
		System.assertNotEquals(result.id, null);
		System.assertEquals(result.name, expectedName);
		System.assertEquals(result.phone, expectedPhone);
		System.assertEquals(result.numberOfEmployees, expectedEmployeeCount);
	}
}
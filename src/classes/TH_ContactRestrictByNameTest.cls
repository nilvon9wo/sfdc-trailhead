@isTest
private class TH_ContactRestrictByNameTest {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Contact.SObjectType
		} 
	);
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void restrictContactNameShouldAllowValidNameToBeInserted() {
		// Arrange
		Contact testContact = MOCK_ContactFactory.create(unitOfWork, 'ValidName');
		
		// Act
		Database.SaveResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.insert(testContact, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(result.isSuccess());
		System.assert(result.getErrors().size() == 0); 
	}
	
	@isTest static void restrictContactNameShouldNotAllowInvalidNameToBeInserted() {
		// Arrange
		Contact testContact = MOCK_ContactFactory.create(unitOfWork, 'INVALIDNAME');
		
		// Act
		Database.SaveResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.insert(testContact, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(!result.isSuccess());
		System.assert(result.getErrors().size() > 0); 
		System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result.getErrors()[0].getMessage());
	}

	@isTest static void restrictContactNameShouldAllowValidNameToBeUpdated() {
		// Arrange
		Contact testContact = MOCK_ContactFactory.create(unitOfWork, 'ValidName');
		unitOfWork.commitWork();
		testContact.lastName = 'NewValidName';
		
		// Act
		Database.SaveResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.update(testContact, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(result.isSuccess());
		System.assert(result.getErrors().size() == 0); 
	}
	
	@isTest static void restrictContactNameShouldAllowInvalidNameToBeUpdated() {
		// Arrange
		Contact testContact = MOCK_ContactFactory.create(unitOfWork, 'ValidName');
		unitOfWork.commitWork();
		testContact.lastName = 'INVALIDNAME';
		
		// Act
		Database.SaveResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.update(testContact, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(!result.isSuccess());
		System.assert(result.getErrors().size() > 0); 
		System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result.getErrors()[0].getMessage());
	}
}
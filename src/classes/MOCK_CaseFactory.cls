@isTest
public class MOCK_CaseFactory {
	private static fflib_SObjectUnitOfWork unitOfWork = createUnitOfWork();

	public static Case create (String testSubject, TEST_DummyInsertModeEnum insertMode) { 
		Case testCase = new Case(
			subject = testSubject, 
			status = 'New',
			origin = 'Phone',
			Priority = 'Medium'	
		);
		unitOfWork.registerNew(testCase);
		unitOfWork.commitWork(insertMode);
		return testCase;
	}	

	public static Case create (TEST_DummyInsertModeEnum insertMode) {
		return create ('Test Record', insertMode);
	} 
	
	// ------------------------------------------------------------------------------------
	
	private static fflib_SObjectUnitOfWork createUnitOfWork() {
		return new fflib_SObjectUnitOfWork (
			new Schema.SObjectType[]{
				Case.SObjectType
			}
		);
	}
	
}
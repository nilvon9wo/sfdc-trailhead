@isTest
public class MOCK_ContactFactory {
	public static final String targetLastName = 'Roth';
	public static final String targetDepartment = 'Finance';

	private static Integer testContactCount = 0;
	public static Contact createTestContact(Boolean hasTargetLastName, Boolean hasTargetDepartment, Boolean insertNow) {
		String firstName = 'Jane';
		String lastName = hasTargetLastName ? targetLastName : 'Smith';
		String email = firstName + '.' + lastName + testContactCount++ + '@example.com';
		String department = hasTargetDepartment ? targetDepartment : 'Other Department';
		String description = 'Contact of ' + datetime.now();
		
		Contact contact = new Contact (
			firstName = firstName,
			lastName = lastName,
			email = email,
			department = department,
			description = description
		);
		
		if (insertNow){
			TEST_MockDMLHelper.mockInsert  ( contact );
		}
		
		return contact;
	} 
	
	public static Contact createTestContact() {
		Boolean NOT_TARGET_NAME = false; 
		Boolean NOT_TARGET_DEPARTMENT = false; 
		return createTestContact(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER);
	}
}
@isTest
public class MOCK_ContactFactory {
	public static final String targetLastName = 'Roth';
	public static final String targetDepartment = 'Finance';

	private static Integer testContactCount = 0;

	public static List<Contact> createList(fflib_SObjectUnitOfWork unitOfWork, Integer quantity) {
		List<Contact> contactList = new List<Contact>(); 
		for (Integer i = 1; i <= quantity; i++){
			contactList.add(create(unitOfWork, i)); 
		}
		return contactList;
	} 
	
	public static Contact create(fflib_SObjectUnitOfWork unitOfWork, String lastName) {
		Contact contact = create(lastName, 'Education', DAO_Timing.LATER);
		unitOfWork.registerNew(contact);
		return contact;
	}

	public static Contact create(fflib_SObjectUnitOfWork unitOfWork, Integer i) {
		Contact contact = create('Rosberg', 'Education', DAO_Timing.LATER);
		unitOfWork.registerNew(contact);
		return contact;
	}
	
	public static Contact create(String lastName, String department, Boolean insertNow) {
		String firstName = 'Jane';
		String email = firstName + '.' + lastName + testContactCount++ + '@example.com';
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


	public static Contact create(Boolean hasTargetLastName, Boolean hasTargetDepartment, Boolean insertNow) {
		String lastName = hasTargetLastName ? targetLastName : 'Smith';
		String department = hasTargetDepartment ? targetDepartment : 'Other Department';
		return create(lastName, department, insertNow);
	} 
	
	public static Contact create() {
		Boolean NOT_TARGET_NAME = false; 
		Boolean NOT_TARGET_DEPARTMENT = false; 
		return create(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER);
	}
}
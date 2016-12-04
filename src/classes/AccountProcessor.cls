public class AccountProcessor {
	@future()
	public static void countContacts(List<Id> accountIdList) {
		DAO_accountDao accountDao = new DAO_accountDao(); 
		Set<Id> accountIdSet = new Set<Id>(accountIdList); 
		List<Account> accountList = accountDao.getWithContactsByAccountIds(accountIdSet);
		for (Account account : accountList) {
			System.debug('########## AccountProcessor account: ' + account.name);
			System.debug('########## AccountProcessor account: ' + account.name);
			
			account.number_of_contacts__c = (account.contacts != null)
												? account.contacts.size()
												: 0; 
			System.debug('########## AccountProcessor number_of_contacts__c: ' + account.number_of_contacts__c);
		}
		accountDao.doUpdate(accountList);
	}
}
public class TH_AccountProcessorBatchable {
	DAO_accountDao accountDao;
	
	public TH_AccountProcessorBatchable(DAO_accountDao accountDao) {
		this.accountDao = accountDao;
	}
	
	public TH_AccountProcessorBatchable() {
		this(new DAO_accountDao());
	}
	

	@future()
	public static void countContacts(List<Id> accountIdList) {
		TH_AccountProcessorBatchable TH_AccountProcessorBatchable = new TH_AccountProcessorBatchable();
		TH_AccountProcessorBatchable.updateContactCount(accountIdList);
	}
	
	@testVisible() 
	private List<Account> updateContactCount(List<Id> accountIdList) {
		Set<Id> accountIdSet = new Set<Id>(accountIdList); 
		List<Account> accountList = accountDao.getWithContactsByAccountIds(accountIdSet);
		List<Account> updatedAccountList = setContactCount(accountList);
		UTIL_ResultListWrapper resultWrapper = accountDao.doUpdate(updatedAccountList);
		return accountList;
	}
	
	@testVisible()
	private List<Account> setContactCount(List<Account> accountList) {
		for (Account account : accountList) {
			account.number_of_contacts__c = account.contacts.size(); 
		}
		return accountList;
	}
}
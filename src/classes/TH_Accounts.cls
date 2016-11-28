public class TH_Accounts extends fflib_SObjectDomain {
	List<Account> accountList;
	
	public TH_Accounts(List<Account> accountList) {
		super(accountList);
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> accountList) {
			return new TH_Accounts (accountList);
		}
	}
	
	public void updateOpportunityActivity(fflib_SObjectUnitOfWork unitOfWork) {
		for (Account account : (List<Account>) Records) {
			account.description = 'Last Opportunity Raised ' + System.today();
			unitOfWork.registerDirty(account);
		}
	}
}
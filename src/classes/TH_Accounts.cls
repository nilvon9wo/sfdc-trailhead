public class TH_Accounts  {
	fflib_SObjectUnitOfWork unitOfWork;
	List<Account> accountList;
	
	public TH_Accounts(List<Account> accountList, fflib_SObjectUnitOfWork unitOfWork) {
		this.accountList = accountList;
		this.unitOfWork = unitOfWork;
	} 

	public TH_Accounts setDefaultDescription(List<Account> accountList){
		for (Account account : (List<Account>) accountList) {
			if (account.description == null) { 
				account.description = 'Domain classes rock!';
				unitOfWork.registerNew(account);
			}
		}
		return this;
	}
	
	public TH_Accounts setAnnualRevenueFromDescriptonMutation(Map<Id,Account> oldAccountByIdMap, List<Account> newAccountList){
		for (Account newAccount : newAccountList) {
			String oldDescription = oldAccountByIdMap.get(newAccount.id).description;
			newAccount.annualRevenue = oldDescription.getLevenshteinDistance(newAccount.description);
			unitOfWork.registerNew(newAccount);
		}
		return this;
	}

	public TH_Accounts updateOpportunityActivity() {
		for (Account account : accountList) {
			account.description = 'Last Opportunity Raised ' + System.today();
			unitOfWork.registerDirty(account);
		}
		return this;
	}
	
}
public class TH_Accounts  {
	private fflib_SObjectUnitOfWork unitOfWork;
	private DAO_OpportunitiesDao opportunitiesdao;
	private List<Account> accountList; 

	public TH_Accounts(List<Account> accountList, fflib_SObjectUnitOfWork unitOfWork, DAO_OpportunitiesDao opportunitiesdao) {
		this.accountList = accountList;
		this.unitOfWork = unitOfWork;
		this.opportunitiesdao = opportunitiesdao;
	}

	public TH_Accounts(List<Account> accountList, fflib_SObjectUnitOfWork unitOfWork) {
		this(accountList, unitOfWork, new DAO_OpportunitiesDao());
	}
	
	// ----------------------------------------------------------------------------------

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
			if (newAccount.id != null){
				unitOfWork.registerDirty(newAccount);
			}
			else {
				unitOfWork.registerNew(newAccount);
			}
			
		}
		return this;
	}
	
	public TH_Accounts setShippingStateToBillingState(List<Account> accountList){
		for (Account account: accountList) {
			account.shippingState = account.billingState;
			if (account.id != null){
				unitOfWork.registerDirty(account);
			}
			else {
				unitOfWork.registerNew(account);
			}
		}
		return this;
	}
	
	public TH_Accounts createNewOpportunities(List<Account> accountList) {
		List<Opportunity> newOpportunityList = new List<Opportunity>();
		for (Account account : accountList) {
			Opportunity opportunity = new Opportunity(
				name = account.name + ' Opportunity',
				accountId = account.id,
				stageName = 'Prospecting',
				type = 'New Customer',
				closeDate = System.today().addMonths(1)
			);
			newOpportunityList.add(opportunity);
		}
		this.opportunitiesDao.doInsert(newOpportunityList);
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
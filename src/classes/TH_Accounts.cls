public class TH_Accounts  {
	public static final String CANNOT_DELETE_WITN_OPPORTUNITIES = 'Cannot delete account with related opportunities'; 

	private DAO_UnitOfWork unitOfWork;
	private DAO_opportunitiesDao opportunitiesDao;
	private List<Account> accountList;
	private DAO_AccountDao accountDao;
	private LOG_Logger logger;

	public TH_Accounts(
						List<Account> accountList, 
						DAO_UnitOfWork unitOfWork, 
						DAO_accountDao accountDao, 
						DAO_opportunitiesDao opportunitiesDao,
						LOG_Logger logger
					) {
		this.accountList = accountList;
		this.unitOfWork = unitOfWork;
		this.accountDao = accountDao; 
		this.opportunitiesDao = opportunitiesDao;
		this.logger = logger;
	}

	public TH_Accounts(List<Account> accountList, DAO_UnitOfWork unitOfWork) {
		this(accountList, unitOfWork, new DAO_accountDao(), new DAO_opportunitiesDao(), new LOG_Logger());
	}

	public TH_Accounts(List<Account> accountList, fflib_SObjectUnitOfWork unitOfWork) {
		this(accountList, new DAO_UnitOfWork(unitOfWork));
	}
	
	// ----------------------------------------------------------------------------------

	public TH_Accounts setDefaultDescription(){
		for (Account account : (List<Account>) this.accountList) {
			if (account.description == null) { 
				account.description = 'Domain classes rock!';
				unitOfWork.register(account);
			}
		}
		return this;
	}
	
	public TH_Accounts setAnnualRevenueFromDescriptonMutation(Map<Id,Account> oldAccountByIdMap){
		for (Account newAccount : this.accountList) {
			String oldDescription = oldAccountByIdMap.get(newAccount.id).description;
			String newDescription = newAccount.description;
			if (newDescription != null){
				newAccount.annualRevenue = oldDescription.getLevenshteinDistance(newDescription);
			}
		}
		return this; 
	}
	
	public TH_Accounts matchShippingToBilling(){
		for (Account account: this.accountList) {
			if (account.billingPostalCode != null && account.match_billing_address__c) {
				account.shippingCity = account.billingCity;
				account.shippingCountry = account.billingCountry;
				account.shippingGeocodeAccuracy = account.billingGeocodeAccuracy;
				account.shippingLatitude = account.billingLatitude;
				account.shippingLongitude = account.billingLongitude;
				account.shippingPostalCode = account.billingPostalCode;
				account.shippingState = account.billingState;
				account.shippingStreet = account.billingStreet;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				account.shippingState = account.billingState;
				unitOfWork.register(account);
			}
		}
		return this;
	}
	
	public TH_Accounts createNewOpportunities() { 
		List<Account> accountsWithOutOpportunityList = this.accountDao.getThoseWithoutOpportuntiesByAccountId(this.accountList);
		Map<Id, Account> accountsByIdMap = new Map<Id, Account>(this.accountList);

		List<Opportunity> newOpportunityList = new List<Opportunity>();
		for (Account account : accountsWithOutOpportunityList) {
			newOpportunityList.add(new Opportunity(
				name = account.name + ' Opportunity',
				accountId = account.id,
				stageName = 'Prospecting',
				type = 'New Customer',
				closeDate = System.today().addMonths(1)
			));
		}

		this.opportunitiesDao.doInsert(newOpportunityList);
		return this;
	}
	
	public TH_Accounts updateOpportunityActivity() {
		for (Account account : accountList) {
			account.description = 'Last Opportunity Raised ' + System.today();
			unitOfWork.register(account);
		}
		return this;
	}
	
	public TH_Accounts updateExistingOpportunityDescriptions() {
		List<Opportunity> opportunityList = opportunitiesDao.getByAccountIds(this.accountList);
		for (Opportunity opportunity : opportunityList) {
			if ((opportunity.probability >= 50) && (opportunity.probability < 100)) {
				opportunity.description = 'New description for opportunity';
			}
			unitOfWork.register(opportunity);
		}
		return this;
	}
	
	// ----------------------------------------------------------------------------------

	public TH_Accounts preventDeletionOfAccountsWithOpportunities() {
		Map<Id, Account> accountsByIdMap = new Map<Id, Account>(this.accountList);
		List<Account> accountsWithOpportunities = this.accountDao.getWithOpportuntiesByAccountId(this.accountList); 
		
		for (Account account : accountsWithOpportunities) {
			accountsByIdMap.get(account.id).addError(CANNOT_DELETE_WITN_OPPORTUNITIES);		
		}
		return this;
	}
}
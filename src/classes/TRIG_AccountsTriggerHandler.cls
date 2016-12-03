public class TRIG_AccountsTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Account.SObjectType,
			Opportunity.SObjectType
		} 
	);
	List<Account> accountList;
	TH_Accounts accounts;
	LOG_Logger logger;
	
	public TRIG_AccountsTriggerHandler(List<Account> accountList, TH_Accounts accounts, LOG_Logger logger) {
		super(accountList);
		this.accountList = accountList;
		this.accounts = accounts;
		this.logger = logger;
	}
 
	public TRIG_AccountsTriggerHandler(List<Account> accountList) {
		this(accountList, new TH_Accounts(accountList, unitOfWork), new LOG_Logger());
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> accountList) {
			return new TRIG_AccountsTriggerHandler (accountList);
		}
	}
	
	// ------------------------------------------------------------------------------
	
	public override void onApplyDefaults() {
		accounts.setDefaultDescription();
	}

    public override void onBeforeInsert() {
    	logger.info('Hello World');
    	
    	accounts.setDefaultDescription()
    		.matchShippingToBilling();
    	
    	//TH_HypotheticalCalloutService.makeCallout(); 
    }
    
    public override void onAfterInsert() {
    	accounts.createNewOpportunities(); 
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingAccountMap) {
    	accounts.matchShippingToBilling()
    	    	.setAnnualRevenueFromDescriptonMutation((Map<Id,Account>)existingAccountMap);
    	
    	//TH_HypotheticalCalloutService.makeCallout();
    } 
    
    public override void onAfterUpdate(Map<Id,SObject> existingAccountMap) {
    	accounts.createNewOpportunities()
    		.updateExistingOpportunityDescriptions(); 
    		
		unitOfWork.commitWork();    		 
    }

    public override void onBeforeDelete() {
    	accounts.preventDeletionOfAccountsWithOpportunities();
    }
}
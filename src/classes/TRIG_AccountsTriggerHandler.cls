public class TRIG_AccountsTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Account.SObjectType,
			Opportunity.SObjectType
		} 
	);
	List<Account> accountList;
	TH_Accounts accounts;
	
	public TRIG_AccountsTriggerHandler(List<Account> accountList, TH_Accounts accounts) {
		super(accountList);
		this.accountList = accountList;
		this.accounts = accounts;
	}
 
	public TRIG_AccountsTriggerHandler(List<Account> accountList) {
		this(accountList, new TH_Accounts(accountList, unitOfWork));
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
    	accounts.setDefaultDescription()
    		.matchShippingToBilling();
    }
    
    public override void onAfterInsert() {
    	accounts.createNewOpportunities(); 
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingAccountMap) {
    	accounts.matchShippingToBilling()
    	    	.setAnnualRevenueFromDescriptonMutation((Map<Id,Account>)existingAccountMap);
    } 
    
    public override void onAfterUpdate(Map<Id,SObject> existingAccountMap) {
    	accounts.createNewOpportunities()
    		.updateExistingOpportunityDescriptions(); 
    }

    public override void onBeforeDelete() {
    	accounts.preventDeletionOfAccountsWithOpportunities();
    }
}
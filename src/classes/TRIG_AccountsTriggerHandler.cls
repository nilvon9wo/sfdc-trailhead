public class TRIG_AccountsTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Account.SObjectType
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
	
	public override void onApplyDefaults() {
		accounts.setDefaultDescription((List<Account>) Records);
		
	}

    public override void onBeforeInsert() {
    	accounts.setShippingStateToBillingState(this.accountList); 
    }
    
    public override void onAfterInsert() {
    	accounts.createNewOpportunities(this.accountList); 
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingAccountMap) {
    	accounts.setAnnualRevenueFromDescriptonMutation((Map<Id,Account>)existingAccountMap, (List<Account>) Records);
    } 
    
    public override void onBeforeDelete() {
    	accounts.preventDeletionOfAccountsWithOpportunities();
    }
}
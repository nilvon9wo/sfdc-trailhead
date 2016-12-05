public class DAO_AccountsSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Account.id,
                Account.annualRevenue,
                Account.billingCity,
                Account.billingPostalCode,
                Account.billingState,
                Account.billingStreet,
                Account.description,
                Account.id,
                Account.name,
                Account.phone
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }

    public List<Account> selectById(Set<Id> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }

    public List<Account> selectById(List<Id> idList) {
        return this.selectSObjectsById(new Set<Id>(idList));
    }

    public List<Account> selectAllAccountList() {
        return (List<Account>) Database.query(
                newQueryFactory()
                        .toSOQL()
        );
    }

    public Map<Id, Account> selectAllAccountMap() {
        return new Map<Id, Account>((List<Account>) Database.query(
                newQueryFactory()
                        .toSOQL()
        ));
    }

    public List<Account> selectByExactName(String accountName) {
        return (List<Account>) Database.query(
                newQueryFactory()
                        .setCondition('name = :accountName')
                        .toSOQL()
        ); 
    }

    public virtual List<Account> selectWithContactsByAccountIds (Set<Id> idSet) {
        return (List<Account>) Database.query(
                getAccountWithContactQueryFactory()
                .setCondition('id IN :idSet')
                .toSOQL()
        );
    }

    public virtual List<Account> selectWithContactsByExactName (String accountName) {
        return (List<Account>) Database.query(
                getAccountWithContactQueryFactory()
                .setCondition('name = :accountName')
                .toSOQL()
        );
    }
    
    public virtual Database.QueryLocator selectLocatorWithContactsByBillingCountry(String country) {
        return Database.getQueryLocator(
                getAccountWithContactQueryFactory()
                .setCondition('billingCountry = :country')
                .toSOQL()
        );
    }
    
    public virtual List<Account> selectWithOpportuntiesByAccountId(Set<Id> accountId) {
        fflib_QueryFactory accountQueryFactory = newQueryFactory();
        fflib_QueryFactory opportunitiesQueryFactory = new DAO_OpportunitiesSelector()
                .addQueryFactorySubselect(accountQueryFactory);

        return (List<Account>) Database.query(
                accountQueryFactory
                .setCondition('id IN :idSet' 
                		+ ' AND id IN (SELECT accountId FROM Opportunity)'
                	)
                .toSOQL()
        );
    }

    public virtual List<Account> selectThoseWithoutOpportuntiesByAccountId(Set<Id> idSet) {
        fflib_QueryFactory accountQueryFactory = newQueryFactory();
        return (List<Account>) Database.query(
                accountQueryFactory
                .setCondition('id IN :idSet' 
                		+ ' AND id NOT IN (SELECT accountId FROM Opportunity)'
                	)
                .toSOQL()
        );
    }


    public List<Account> selectByNameLikeness(String nameLikeness) {
        return (List<Account>) Database.query(
                newQueryFactory()
                        .setCondition('LIKE :nameLikeness')
                        .toSOQL()
        );
    }
    
	public List<Account> selectByBillingState(String stateAbbreviation, Integer recordLimit) {
		recordLimit = (recordLimit > -1) ? recordLimit : 200; 

        return (List<Account>) Database.query(
                newQueryFactory()
                        .setCondition('billingState =: stateAbbreviation')
                        .setLimit(recordLimit)
                        .toSOQL()
        );
	}
	
	// -----------------------------------------------------------------------
	
	 private virtual fflib_QueryFactory getAccountWithContactQueryFactory() {
        fflib_QueryFactory accountQueryFactory = newQueryFactory();
        fflib_QueryFactory contactQueryFactory = new DAO_ContactSelector()
                .addQueryFactorySubselect(accountQueryFactory);
        return accountQueryFactory;
    }
}
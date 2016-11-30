public class DAO_OpportunitiesSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Opportunity.amount,
                Opportunity.accountId,
                Opportunity.closeDate,
                Opportunity.description,
                Opportunity.discountType__c,
                Opportunity.expectedRevenue,
                Opportunity.id,
                Opportunity.name,
                Opportunity.pricebook2Id,
                Opportunity.probability,
                Opportunity.stageName,
                Opportunity.type
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Opportunity.sObjectType;
    }

    public List<Opportunity> selectById(Set<Id> idSet) {
        String query = String.format(
                'SELECT {0} ' +
                        'FROM {1}, ' +
                        '(SELECT unitPrice FROM OpportunityLineItems) ' +
                        'WHERE SystemModStamp = LAST_N_DAYS:30 ' +
                        'ORDER BY {2} ',
                new List<String>{
                        getFieldListString(),
                        getSObjectName(),
                        getOrderBy()
                }
        );
        return (List<Opportunity>) Database.query(query);
    }

    public List<Opportunity> selectById(List<Id> idList) {
        return this.selectById(new Set<Id>(idList));
    }

    public List<Opportunity> selectByIdWithProducts(Set<Id> idSet) {
        fflib_QueryFactory opportunitiesQueryFactory = newQueryFactory();
        fflib_QueryFactory lineItemsQueryFactory = new DAO_OpportunityLineItemsSelector()
                .addQueryFactorySubselect(opportunitiesQueryFactory);


        new DAO_PricebookEntriesSelector().configureQueryFactoryFields(lineItemsQueryFactory, 'PricebookEntry');
        new DAO_ProductsSelector().configureQueryFactoryFields(lineItemsQueryFactory, 'PricebookEntry.Product2');
        new DAO_PricebooksSelector().configureQueryFactoryFields(lineItemsQueryFactory, 'PricebookEntry.Pricebook2');

        return (List<Opportunity>) Database.query(
                opportunitiesQueryFactory.setCondition('id IN :idSet').toSOQL()
        );
    }

    public List<Opportunity> selectRecentlyUpdated(Integer recordLimit) {
        return (List<Opportunity>) Database.query(
                newQueryFactory()
                        .setCondition('SystemModstamp = LAST_N_DAYS:30')
                        .setLimit(recordLimit)
                        .toSOQL()
        );
    }

    public List<DTO_OpportunityInfo> selectOpportunityInfoById (Set<Id> idSet) {
        List<DTO_OpportunityInfo> opportunityInfoList = new List<DTO_OpportunityInfo>();
        for (Opportunity opportunity : Database.query(
                newQueryFactory(false)
                        .selectField(Opportunity.id)
                        .selectField(Opportunity.amount)
                        .selectField(Opportunity.stageName)
                        .selectField('Account.name')
                        .selectField('Account.accountNumber')
                        .selectField('Account.owner.name')
                        .selectField(Opportunity.id)
                        .setCondition('id IN :idSet')
                        .toSOQL()
        )) {
            opportunityInfoList.add(new DTO_OpportunityInfo(opportunity));
        }
        return opportunityInfoList;
    }

    public List<DTO_OpportunityInfo> selectOpportunityInfoByIdAsSystem (Set<Id> idSet) {
        return new SelectOpportunityInfoAsSystem().selectOpportunityInfo(this, idSet);
    }

    private without sharing class SelectOpportunityInfoAsSystem {
        public List<DTO_OpportunityInfo> selectOpportunityInfo(DAO_OpportunitiesSelector selector, Set<Id> idSet) {
            return selector.selectOpportunityInfoById(idSet);
        }
    }
}
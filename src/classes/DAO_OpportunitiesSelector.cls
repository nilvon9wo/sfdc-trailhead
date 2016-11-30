public class DAO_OpportunitiesSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Opportunity.amount
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

    public List<Opportunity> selectRecentlyUpdated(Integer recordLimit) {
        return (List<Opportunity>) Database.query(
                newQueryFactory()
                        .setCondition('SystemModstamp = LAST_N_DAYS:30')
                        .setLimit(recordLimit)
                        .toSOQL()
        );
    }

    public List<DTO_OpportunityInfo> selectOpportunityInfo(Set<Id> idSet) {
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
}
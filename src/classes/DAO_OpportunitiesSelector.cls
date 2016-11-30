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
        String query = String.format(
                'SELECT {0} ' +
                        'FROM {1} ' +
                        'WHERE SystemModStamp = LAST_N_DAYS:30 ' +
                        'ORDER BY {2} ' +
                        'LIMIT {3}',
                new List<String>{
                        getFieldListString(),
                        getSObjectName(),
                        getOrderBy(),
                        String.valueOf(recordLimit)
                }
        );
        return (List<Opportunity>) Database.query(query);
    }
}
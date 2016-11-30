public class DAO_ProductsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Product2.Description,
                Product2.Id,
                Product2.IsActive,
                Product2.Name,
                Product2.ProductCode
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }

    public List<Product2> selectById(Set<Id> idSet) {
        return (List<Product2>) selectSObjectsById(idSet);
    }

    public override String getOrderBy() {
        return 'IsActive DESC, ProductCode';
    }

    public List<Product2> selectRecentlyUpdated(Integer recordLimit) {
        return (List<Product2>) Database.query(
                newQueryFactory().
                        setCondition('SystemModstamp = LAST_N_DAYS:30').
                        setLimit(recordLimit).
                        toSOQL()
        );
    }
}
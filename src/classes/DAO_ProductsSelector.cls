public class DAO_ProductsSelector extends fflib_SObjectSelector {

    public DAO_ProductsSelector(Boolean includeFieldSetFields) {
        super(includeFieldSetFields);
    }

    public DAO_ProductsSelector() {
        this(false);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Product2.description,
                Product2.id,
                Product2.isActive,
                Product2.name,
                Product2.productCode
        };
    }

    public override List<Schema.FieldSet> getSObjectFieldSetList() {
        return new List<Schema.FieldSet>{
                SObjectType.Product2.FieldSets.Trailhead
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }

    public List<Product2> selectById(Set<Id> idSet) {
        return (List<Product2>) selectSObjectsById(idSet);
    }

    public List<Product2> selectById(Set<Id> idSet, Schema.FieldSet fieldSet) {
        return (List<Product2>) Database.query(
                newQueryFactory()
                        .selectFieldSet(fieldSet)
                        .setCondition('id IN :idSet')
                        .toSOQL()
        );
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
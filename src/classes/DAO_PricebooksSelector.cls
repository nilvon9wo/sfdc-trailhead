public class DAO_PricebooksSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Pricebook2.description,
                Pricebook2.id,
                Pricebook2.isActive,
                Pricebook2.isStandard,
                Pricebook2.name
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Pricebook2.sObjectType;
    }
}
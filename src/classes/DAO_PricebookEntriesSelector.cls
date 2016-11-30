public class DAO_PricebookEntriesSelector extends fflib_SObjectSelector {
    private static Boolean INCLUDE_FIELD_SET_FIELDS = false;
    private static Boolean ENFORCE_OBJECT_LEVEL_SECURITY = false;
    private static Boolean ENFORCE_FIELD_LEVEL_SECURITY = false;

    public DAO_PricebookEntriesSelector(Boolean enforceObjectSecurity, Boolean enforceFieldSecurity) {
        super(INCLUDE_FIELD_SET_FIELDS, enforceObjectSecurity, enforceFieldSecurity);
    }

    public DAO_PricebookEntriesSelector(Boolean enforceObjectAndFieldSecurity) {
        this(enforceObjectAndFieldSecurity, enforceObjectAndFieldSecurity);
    }

    public DAO_PricebookEntriesSelector() {
        this(ENFORCE_OBJECT_LEVEL_SECURITY, ENFORCE_FIELD_LEVEL_SECURITY);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                PricebookEntry.id,
                PricebookEntry.isActive,
                PricebookEntry.name,
                PricebookEntry.pricebook2Id,
                PricebookEntry.product2Id,
                PricebookEntry.productCode,
                PricebookEntry.unitPrice,
                PricebookEntry.useStandardPrice
        };
    }

    public Schema.SObjectType getSObjectType() {
        return PricebookEntry.sObjectType;
    }
}
public class DAO_OpportunityInfo {
    private Opportunity opportunity;
    public Id id { get {return opportunity.id;} }
    public Decimal amount { get {return opportunity.amount;} }
    public String stage { get {return opportunity.stageName;} }
    public String accountName { get {return opportunity.account.name;} }
    public String accountNumber { get {return opportunity.account.accountNumber;} }
    public String accountOwner { get {return opportunity.account.owner.name;} }

    public DAO_OpportunityInfo(Opportunity opportunity) {
        this.opportunity = opportunity;
    }
}
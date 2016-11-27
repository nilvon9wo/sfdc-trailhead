public class TH_OpportunitiesService { 
	public void applyDiscounts(Set<Id> opportunityIdSet, Decimal discountPercentage) {
		// TODO
	}

	public void applyDiscounts(Id opportunityId, Decimal discountPercentage) {
		this.applyDiscounts(new Set<Id>{opportunityId}, discountPercentage);
	}
}
public class DAO_LeadDao{
	public DAO_LeadSelector daoSelector;
	
	public DAO_LeadDao(DAO_LeadSelector daoSelector){
		this.daoSelector = daoSelector;
	}
	 
	public DAO_LeadDao(){
		this(new DAO_LeadSelector());
	}
	
	public virtual UTIL_ResultListWrapper doUpdate(List<Lead> leadList){
		return DAO_SObjectDMLHelper.doUpdate(leadList);
	}
	
	public List<Lead> getWithBlankSource(Integer quantity){
		return daoSelector.selectWithBlankSource(quantity);
	}
}
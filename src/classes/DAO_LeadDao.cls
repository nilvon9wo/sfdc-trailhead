public class DAO_LeadDao{
	public virtual UTIL_ResultListWrapper doUpdate(List<Lead> leadList){
		return DAO_SObjectDMLHelper.doUpdate(leadList);
	}
}
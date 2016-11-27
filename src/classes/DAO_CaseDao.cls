public virtual class DAO_CaseDao {
	public virtual UTIL_ResultListWrapper doUpdate(List<Case> caseList){
		return DAO_SObjectDMLHelper.doUpdate(caseList);
	}
	
	public virtual List<Case> getByIds (Set<Id> idSet) {
		return [ SELECT id FROM Case WHERE id IN :idSet ];
	}  
}
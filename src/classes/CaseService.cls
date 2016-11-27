public class CaseService {
	DAO_CaseDao caseDao; 
	
	public CaseService(DAO_CaseDao caseDao){
		this.caseDao = caseDao;
	}
	
	public CaseService(){
		this(new DAO_CaseDao());
	}

	public static void closeCases(Set<Id> caseIdSet, String reason) {
		CaseService service = new CaseService();
		service.close(caseIdSet, reason);
	}
	
	public void close(Set<Id> caseIdSet, String reason) {
		List<Case> caseList = caseDao.getByIds(caseIdSet);
		List<Case> updateCaseList = new List<Case>();
		
		for (Case currentCase : caseList) {
			currentCase.status = 'Closed';
			currentCase.reason = reason;
			updateCaseList.add(currentCase);	
		} 
		
		caseDao.doUpdate(updateCaseList); 
	}
	    
}
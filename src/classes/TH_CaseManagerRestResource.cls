@RestResource(urlMapping='/Cases/*')
global with sharing class TH_CaseManagerRestResource {
	DAO_CaseDao caseDao;
	
	TH_CaseManagerRestResource(DAO_CaseDao caseDao) {
		this.caseDao = caseDao;
	}

	TH_CaseManagerRestResource() {
		this(new DAO_CaseDao());
	}
	
	@HttpGet
	global static Case getCaseById(){
		TH_CaseManagerRestResource resource = new TH_CaseManagerRestResource();
		return resource.getById(RestContext.request);		
	}
	
	private Case getById(RestRequest request) {
		Id caseId = extractIdFromUrl(request);
		Set<Id> idSet = new Set<Id>{caseId};
		return this.caseDao.getByIds(idSet)[0];
	}
	
	@HttpPost
	global static Id createCase(String subject, String status, String origin, String priority) {
		TH_CaseManagerRestResource resource = new TH_CaseManagerRestResource();
		return resource.create(subject, status, origin, priority);		
	}
	
	private Id create(String subject, String status, String origin, String priority) {
		Case newCase = new Case (
			subject = subject,
			status = status,
			origin = origin, 
			priority = priority 
		);
		this.caseDao.doInsert(new List<Case>{newCase});
		return newCase.id;
	}
	
	@HttpPut
	global static Id upsertCase(String subject, String status, String origin, String priority, String id) {
		TH_CaseManagerRestResource resource = new TH_CaseManagerRestResource();
		return resource.doUpsert(subject, status, origin, priority, (Id) id);		
	}
	
	private Id doUpsert(String subject, String status, String origin, String priority, Id Id) {
		Case currentCase = new Case (
			id = id,
			subject = subject,
			status = status,
			origin = origin,  
			priority = priority  
		);
		this.caseDao.doUpsert(new List<Case>{currentCase});
		return currentCase.id;
	}
	
	@HttpPatch
	global static Id updateCaseFields() {
		TH_CaseManagerRestResource resource = new TH_CaseManagerRestResource();
		return resource.updateFields(RestContext.request);		
	}
	
	private Id updateFields(RestRequest request) {
		Case currentCase = this.getById(request);
		
		Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
		for (String fieldName : params.keySet()) {
			currentCase.put(fieldName, params.get(fieldName));
		}
		this.caseDao.doUpdate(new List<Case>{currentCase});
		return currentCase.id;
	}
	
	@HttpDelete
	global static void deleteCase() {
		TH_CaseManagerRestResource resource = new TH_CaseManagerRestResource();
		resource.doDelete(RestContext.request);		 
	}
	
	private void doDelete(RestRequest request){
		Case currentCase = this.getById(request);
		caseDao.doDelete(new List<Case>{currentCase});
	}
	
	private Id extractIdFromUrl(RestRequest request){
		String caseId = request.requestURI
			.substring(request.requestURI.lastIndexOf('/') +1);
		return (Id) caseId;
	}
}
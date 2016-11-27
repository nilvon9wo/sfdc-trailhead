@RestResource(urlMapping='/case/*/close') 
global with sharing class CaseCloseResource {
	CaseService caseService;
	
	public CaseCloseResource(CaseService caseService){
		this.caseService = caseService;
	}     

	public CaseCloseResource(){
		this (new CaseService());
	}
	
	@HttpPost
    global static void closeCase(String reason) {
		CaseCloseResource resource = new CaseCloseResource();
		resource.close(reason);
	}
	
	private void close(String reason) {
		RestRequest request = RestContext.request;
		String[] uriParts = request.requestURI.split('/');
		Id caseId = uriParts[2];
		
		this.caseService.close (new Set<Id>{ caseId }, reason);
	}	    
}
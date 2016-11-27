@RestResource(urlMapping='/case/*/close') 
global with sharing class TH_CaseCloseResource {
	TH_CaseService caseService;
	
	public TH_CaseCloseResource(TH_CaseService caseService){
		this.caseService = caseService;
	}     

	public TH_CaseCloseResource(){
		this (new TH_CaseService());
	}
	
	@HttpPost
    global static void closeCase(String reason) {
		TH_CaseCloseResource resource = new TH_CaseCloseResource();
		resource.close(reason);
	}
	
	private void close(String reason) {
		RestRequest request = RestContext.request;
		String[] uriParts = request.requestURI.split('/');
		Id caseId = uriParts[2];
		
		this.caseService.close (new Set<Id>{ caseId }, reason);
	}	    
}
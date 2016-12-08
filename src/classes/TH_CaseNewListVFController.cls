public class TH_CaseNewListVFController {
	public List<Case> getNewCases(){
		return [
			SELECT id, caseNumber
			FROM Case
			WHERE status = 'New'
		];
	}
}
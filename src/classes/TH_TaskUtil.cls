public class TH_TaskUtil {
	public static String getTaskPriority(String leadState) {
		TH_TaskUtil util = new TH_TaskUtil();
		return util.getPriority(leadState);
	}
	
	@testVisible()
	private String getPriority(String leadState){
		if (String.isBlank(leadState) || leadState.length() > 2){
			return null;
		}
		
		return (leadState == 'CA') ? 'High' : 'Normal';
	}
	
	public void remindOwners(List<Opportunity> opportunityList) {
		// TODO
	}
}
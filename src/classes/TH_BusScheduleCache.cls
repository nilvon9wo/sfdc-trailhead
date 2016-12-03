public class TH_BusScheduleCache {   
    private Cache.OrgPartition partition;
    private String partitionName = 'local.BusSchedule';
    
    public TH_BusScheduleCache () {
        this.partition = new Cache.OrgPartition(partitionName);
    }
    
    public void putSchedule(String busLine, Time[] schedule) {
        partition.put(busline, schedule);
    }
        
    public Time[] getSchedule(String busLine) {
        Time[] schedule = (Time[]) partition.get(busLine);
        if (schedule == null) {
        	schedule = new List<Time>{
        		Time.newInstance(8,0,0,0),
        		Time.newInstance(17,0,0,0)
        	};
        }
        return schedule;
    } 
}
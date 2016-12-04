global class Console {
	global static void log (Object obj1, Object obj2) {
		String output = String.valueOf(obj1);
		output += (obj2 != null)
			? ' : ' + String.valueOf(obj2)
			: '';
			
		(new LOG_Logger()).debug(output);
	}
	
	global static void log (Object obj1) {
		log(obj1, null);
	}
}
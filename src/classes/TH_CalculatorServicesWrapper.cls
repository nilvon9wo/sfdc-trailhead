public class TH_CalculatorServicesWrapper {
	public static Double add(Double x, Double y){
		TH_CalculatorServices.CalculatorImplPort calculator = new TH_CalculatorServices.CalculatorImplPort();
		return calculator.doAdd(x, y); 
	}		
}
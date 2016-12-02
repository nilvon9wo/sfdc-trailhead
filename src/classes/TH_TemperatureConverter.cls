public class TH_TemperatureConverter {
	public static Decimal FahrenheitToCelcius(Decimal fahrenheit) {
		TH_TemperatureConverter converter = new TH_TemperatureConverter();
		return converter.f2c(fahrenheit);			
	}
	
	@testVisible()    
	private Decimal f2c(Decimal fahrenheit) {
		Decimal celcius = (fahrenheit - 32) * 5/9;
		return celcius.setScale(2);
	}
}
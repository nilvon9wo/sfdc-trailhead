public class TH_CurrencyExchange {
	Cache.OrgPartition orgPartition = Cache.Org.getPartition('localCurrencyCache');
	Cache.SessionPartition sessionPartition = Cache.Session.getPartition('localCurrencyCache');
	
	private static String FAVOURITE = 'FavouriteCurrency';

	TH_CurrencyExchangeAPIWrapper exchangeAPIWrapper;
	
	TH_CurrencyExchange(TH_CurrencyExchangeAPIWrapper exchangeAPIWrapper){
		this.exchangeAPIWrapper = exchangeAPIWrapper;
	}

	TH_CurrencyExchange(){
		this(new TH_CurrencyExchangeAPIWrapper());
	} 
	
	public Decimal getDollarToEuroRate() {
		Decimal cachedRate = (Decimal) orgPartition.get('DollarToEuroRate');
		if (cachedRate == null) {
			cachedRate = exchangeAPIWrapper.getDollarToEuroRate();
			Cache.Org.put('local.CurrencyCache.DollarToEuroRate', cachedRate);
		}
		return cachedRate;
	}
	
	public String setFavoriteCurrency(String favouriteCurrency) {
		sessionPartition.put(FAVOURITE, favouriteCurrency);
		return favouriteCurrency;
	}

	public String getFavoriteCurrency(String favouriteCurrency) {
		return (String) sessionPartition.get(FAVOURITE); 
	}
	    
}
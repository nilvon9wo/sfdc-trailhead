public class TH_ExchangeRateWebServiceWrapper {
	private TH_ExchangeRateDao exchangeRateDao; 

	public TH_ExchangeRateWebServiceWrapper(TH_ExchangeRateDao exchangeRateDao){
		this.exchangeRateDao = exchangeRateDao;
	}
	
	public TH_ExchangeRateWebServiceWrapper(){
		this(new TH_ExchangeRateDao());
	}
	
	private static Map<String, Map<String,Decimal>> dummyRateByCurrencyMap = new Map<String, Map<String,Decimal>>{
		'EUR' => new Map<String,Decimal>{
			'EUR' => 1,
			'GBP' => 0.84,
			'CAD' => 1.42,
			'PLN' => 4.48,
			'INR' => 72.54,
			'AUD' => 1.43,
			'SGD' => 1.51,
			'CHF' => 1.08,
			'MYR' => 1403.95,
			'JPY' => 121.04,
			'CNY' => 7.32
		},
		'GBP' => new Map<String,Decimal>(),
		'CAD' => new Map<String,Decimal>(),
		'PLN' => new Map<String,Decimal>(),
		'INR' => new Map<String,Decimal>(),
		'AUD' => new Map<String,Decimal>(),
		'SGD' => new Map<String,Decimal>(),
		'CHF' => new Map<String,Decimal>(),
		'MYR' => new Map<String,Decimal>(),
		'JPY' => new Map<String,Decimal>(),
		'CNY' => new Map<String,Decimal>()
	};

	public static List<String> baseCurrencyList = new List<String>(dummyRateByCurrencyMap.keySet());
	public static String cacheName = 'ExchangeWebService';
	
	public Map<String, List<ExchangeRate__c>> refreshBaseRates(){
		String tempLoadRates = getLoadRates();
		Map<String, List<ExchangeRate__c>> apiRateByCurrencyMap = getParseValues(tempLoadRates);
		saveRates(apiRateByCurrencyMap);
  		Cache.Org.remove('Rates'); 
  		return apiRateByCurrencyMap;
	}
	
	@testVisible()
	private String getLoadRates(){
		List<String> loadRateList = new List<String>();
		for (String fromCurrency : dummyRateByCurrencyMap.keySet()) {
			Map<String,Decimal> toRateByToCurrencyMap = dummyRateByCurrencyMap.get(fromCurrency); 
			for (String toCurrency : toRateByToCurrencyMap.keySet()) {
				loadRateList.add(fromCurrency + '>' + toCurrency + ':' + toRateByToCurrencyMap.get(toCurrency));
			} 
		}
		return String.join(loadRateList, ';');		
	} 
	
	@testVisible()
	private Map<String, List<ExchangeRate__c>> getParseValues(String tempLoadRates){
		System.debug('######### tempLoadRates:' + tempLoadRates);
		Map<String, List<ExchangeRate__c>> rateByFromCurrencyMap = new Map<String, List<ExchangeRate__c>>();
		for (String fromCurrencyData : tempLoadRates.split(';')) {
			List<String> toRateData = fromCurrencyData 
				.replaceAll('>', ',')
				.replaceAll(':', ',')
				.split(',');
			ExchangeRate__c exchangeRate = new ExchangeRate__c(
				baseCurrency__c = toRateData[0],
				toCurrency__c = toRateData[1],
				rate__c = Decimal.valueOf(toRateData[2]),
				forList__c = true
			);
			String fromCurrency = exchangeRate.baseCurrency__c;
			if (rateByFromCurrencyMap.get(fromCurrency) == null){
				rateByFromCurrencyMap.put(fromCurrency, new List<ExchangeRate__c>());
			} 
			rateByFromCurrencyMap.get(fromCurrency).add(exchangeRate);
		}
		return rateByFromCurrencyMap;
	}
	
	private Map<String, List<ExchangeRate__c>> saveRates (Map<String, List<ExchangeRate__c>> rateByFromCurrencyMap){
		List<ExchangeRate__c> allExchangeRateList = new List<ExchangeRate__c>();
		for (String fromCurrency : rateByFromCurrencyMap.keySet()){
			allExchangeRateList.addAll(rateByFromCurrencyMap.get(fromCurrency));
		}
		exchangeRateDao.doInsert(allExchangeRateList);
		return rateByFromCurrencyMap;
	}
}
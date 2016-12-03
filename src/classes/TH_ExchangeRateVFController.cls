public class TH_ExchangeRateVFController {
    private List<String> currencyList = TH_ExchangeRateWebServiceWrapper.baseCurrencyList;
    public String getCurrencies() {
        return String.join(currencyList, ',');
    }
    private List<ExchangeRate__c> exchangeRateList;   

    private TH_ExchangeRateDao exchangeRateDao;
    private TH_ExchangeRateWebServiceWrapper exchangeRateWebServiceWrapper;

    public TH_ExchangeRateVFController(
            TH_ExchangeRateDao exchangeRateDao,
            TH_ExchangeRateWebServiceWrapper exchangeRateWebServiceWrapper 
        ){
            
        this.exchangeRateDao = exchangeRateDao;
        this.exchangeRateWebServiceWrapper = exchangeRateWebServiceWrapper;
    }
    
    public TH_ExchangeRateVFController(){
        this(new TH_ExchangeRateDao(), new TH_ExchangeRateWebServiceWrapper());
    }
    
    // --------------------------------------------------------------------------------------

    public PageReference init(){
        List<ExchangeRate__c> latestExchangeRateList = exchangeRateDao.getRates();
        if (refreshRequired(latestExchangeRateList)){
            exchangeRateWebServiceWrapper.refreshBaseRates();
        }
        exchangeRateList = getCachedRates();
        return null;
    }
    
    private Boolean refreshRequired(List<ExchangeRate__c> latestExchangeRateList) {
        return latestExchangeRateList == null
            || latestExchangeRateList.size() == 0
            || latestExchangeRateList[0].createdDate.date() < Datetime.now().date();
    }

    // --------------------------------------------------------------------------------------
     
    public List<ExchangeRate__c> getRates() {
        return exchangeRateList;
    }

    public List<ExchangeRate__c> getCachedRates() {
        String cachePath = TH_ExchangeRateWebServiceWrapper.cacheName + 'Rates';
        List<ExchangeRate__c> rates = (List<ExchangeRate__c>) Cache.Org.get(cachePath);
        if (rates == null) {
            rates = exchangeRateDao.getTodaysRates();
            Cache.Org.put(cachePath, rates);
        }
        return rates;
    }
}
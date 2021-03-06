//Generated by wsdl2apex

public class TH_CalculatorServicesAsync {
    public class doDivideResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            TH_CalculatorServices.doDivideResponse response = (TH_CalculatorServices.doDivideResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class doSubtractResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            TH_CalculatorServices.doSubtractResponse response = (TH_CalculatorServices.doSubtractResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class doMultiplyResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            TH_CalculatorServices.doMultiplyResponse response = (TH_CalculatorServices.doMultiplyResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class doAddResponseFuture extends System.WebServiceCalloutFuture {
        public Double getValue() {
            TH_CalculatorServices.doAddResponse response = (TH_CalculatorServices.doAddResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class AsyncCalculatorImplPort {
        public String endpoint_x = 'https://th-apex-soap-service.herokuapp.com/service/calculator';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://calculator.services/', 'TH_CalculatorServices'};
        public TH_CalculatorServicesAsync.doDivideResponseFuture beginDoDivide(System.Continuation continuation,Double arg0,Double arg1) {
            TH_CalculatorServices.doDivide request_x = new TH_CalculatorServices.doDivide();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (TH_CalculatorServicesAsync.doDivideResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              TH_CalculatorServicesAsync.doDivideResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doDivide',
              'http://calculator.services/',
              'doDivideResponse',
              'TH_CalculatorServices.doDivideResponse'}
            );
        }
        public TH_CalculatorServicesAsync.doSubtractResponseFuture beginDoSubtract(System.Continuation continuation,Double arg0,Double arg1) {
            TH_CalculatorServices.doSubtract request_x = new TH_CalculatorServices.doSubtract();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (TH_CalculatorServicesAsync.doSubtractResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              TH_CalculatorServicesAsync.doSubtractResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doSubtract',
              'http://calculator.services/',
              'doSubtractResponse',
              'TH_CalculatorServices.doSubtractResponse'}
            );
        }
        public TH_CalculatorServicesAsync.doMultiplyResponseFuture beginDoMultiply(System.Continuation continuation,Double arg0,Double arg1) {
            TH_CalculatorServices.doMultiply request_x = new TH_CalculatorServices.doMultiply();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (TH_CalculatorServicesAsync.doMultiplyResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              TH_CalculatorServicesAsync.doMultiplyResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doMultiply',
              'http://calculator.services/',
              'doMultiplyResponse',
              'TH_CalculatorServices.doMultiplyResponse'}
            );
        }
        public TH_CalculatorServicesAsync.doAddResponseFuture beginDoAdd(System.Continuation continuation,Double arg0,Double arg1) {
            TH_CalculatorServices.doAdd request_x = new TH_CalculatorServices.doAdd();
            request_x.arg0 = arg0;
            request_x.arg1 = arg1;
            return (TH_CalculatorServicesAsync.doAddResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              TH_CalculatorServicesAsync.doAddResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://calculator.services/',
              'doAdd',
              'http://calculator.services/',
              'doAddResponse',
              'TH_CalculatorServices.doAddResponse'}
            );
        }
    }
}
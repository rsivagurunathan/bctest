public with sharing class ACS_Request { 

    private PageReference endpoint;
    private String end_platform;
    private String http_method;
    private String body;
    private List<ACS_REST_Parameters__c> parameters;

    public ACS_Request(){
        this.endpoint = new PageReference('');
        this.end_platform = '';
        this.http_method = 'POST';
        this.in_test = false;
        this.test_http_response = new  HttpResponse();

    }
    
    public void set_endpoint(String endpoint_url) {
        this.endpoint = new PageReference(endpoint_url);
    }
    
    public void set_end_platform(String platform) {
        this.end_platform = platform;
        Map<String,ACS_REST_Parameters__c> all_parameters = ACS_REST_Parameters__c.getAll();
        this.parameters = new List<ACS_REST_Parameters__c>();

        for ( ACS_REST_Parameters__c param : all_parameters.values()) {
            if (param.platform__c == platform) {
                this.parameters.add(param);
            }
        }

    }

    public void set_http_method(String method) {
        this.http_method = method;
    }

    public void set_body(String body) {
        this.body = body;
    }

    public HttpResponse callout(){
        HttpRequest http_request = this.create_http_request();
        Http http = new Http();
        HttpResponse http_response = (this.in_test)? this.test_http_response : http.send(http_request);
        return http_response;
    }

    private HttpRequest create_http_request() {
        HttpRequest http_request = new HttpRequest();
        http_request.setEndPoint(this.endpoint.getUrl());
        http_request.setMethod(this.http_method);

        for ( ACS_REST_Parameters__c param : this.parameters) {
            if (param.type__c == 'header') {
                http_request.setHeader(param.parameter__c, param.value__C);
            }
        }

        //Set a X-NI-signatureHash in the Header
        if (this.end_platform == 'ACS') {
            String algorithmName = 'HMacSHA1';
            String private_key = '1234';
            //Get Private Key From Parameter List
            for(ACS_REST_Parameters__c param : this.parameters) {
                if(param.name == 'ACS_Private_Key') {
                    private_key = param.value__c;
                }
            }
            //Generate MAC
            Blob mac = Crypto.generateMac(algorithmName,  Blob.valueOf(body), Blob.valueOf(private_key));
            //Base 64 Encode to generate Signature Hash & Set the Signature Hash in the Request Header
            http_request.setHeader('X-NI-signatureHash', EncodingUtil.base64Encode(mac));
        }


        http_request.setBody(this.body);

        return http_request;
    }


    //Variables for test excecution
    private Boolean in_test;
    private HttpResponse test_http_response;

    public void set_in_test(Boolean in_test) {
        this.in_test = in_test;
    }

    public void set_test_http_response(HttpResponse test_http_response) {
        this.test_http_response = test_http_response;
    }

}
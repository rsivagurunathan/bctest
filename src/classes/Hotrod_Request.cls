public with sharing class Hotrod_Request { 

    private PageReference endpoint;
    private String end_platform;
    private String http_method;
    private String body;
    private List<NI_REST_Parameters__c> parameters;

    public Hotrod_Request(){
        this.endpoint = new PageReference('');
        this.end_platform = '';
        this.http_method = 'POST';
        this.in_test = false;
        this.test_http_response = new  HttpResponse();

    }
    
    public void set_endpoint(String endpoint_http, String endpoint_url) {

        if(this.end_platform == 'HEROKU'){
            String username = '';
            String password = '';

            //Get Username and Password From Parameter List
            for(NI_REST_Parameters__c param : this.parameters) {
                if(param.type__c == 'Username'){
                    username = param.value__c;
                } else if(param.type__c == 'Password'){
                    password = param.value__c;
                }
            }
            this.endpoint = new PageReference(endpoint_http+username+':'+password+'@'+endpoint_url);

        }else{
            this.endpoint = new PageReference(endpoint_http+endpoint_url);
        }
    }
    
    public void set_end_platform(String platform) {
        this.end_platform = platform;
        Map<String,NI_REST_Parameters__c> all_parameters = NI_REST_Parameters__c.getAll();
        this.parameters = new List<NI_REST_Parameters__c>();

        for ( NI_REST_Parameters__c param : all_parameters.values()) {
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

        for ( NI_REST_Parameters__c param : this.parameters) {
            if (param.type__c == 'header') {
                http_request.setHeader(param.parameter__c, param.value__C);
            }
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
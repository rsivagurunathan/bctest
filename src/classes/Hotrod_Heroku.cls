public with sharing class Hotrod_Heroku { 

    private string heroku_environemnt;
    private string api_version;
    private string resource;
    private string heroku_http;
    private Hotrod_Request hotrod_request;

    public Hotrod_Heroku(){

        this.api_version = '';
        this.resource = '';
        this.heroku_http = 'http://';
        this.heroku_environemnt = 'hotrod-api-stable.herokuapp.com';
        this.hotrod_request = new Hotrod_Request();
    }

    public response_object new_main_contact(Id contact_id){

        //Get Contact
        Contact c = [SELECT Id, email, Inactive_Contact__c, FirstName, LastName, Account.name, Account.ShippingCity ,Account.ShippingStreet ,Account.ShippingPostalCode FROM Contact WHERE Id = :contact_Id];

        //Init New Response Object
        response_object heroku_response;

        //Generate Contact and Account JSON
        String contact_and_account_JSON = JSON.serializePretty(c);

        //Set params for endpoint resource URL
        this.api_version = '/v1';
        this.resource = '/sf';

        //Init ACS Request
        Hotrod_Request new_hotrod_request = this.hotrod_request;
        new_hotrod_request.set_end_platform('HEROKU');
        new_hotrod_request.set_endpoint(this.heroku_http,this.heroku_environemnt+this.api_version+this.resource);
        new_hotrod_request.set_http_method('POST');
        new_hotrod_request.set_body(contact_and_account_JSON);
        heroku_response = generate_response_object(new_hotrod_request.callout());


        return heroku_response;
    }

    public response_object update_main_contact(Id contact_id){
        //Get Contact
        Contact c = [SELECT Id, email, Inactive_Contact__c, FirstName, LastName, Account.name, Account.ShippingCity ,Account.ShippingStreet ,Account.ShippingPostalCode FROM Contact WHERE Id = :contact_Id];

        //Init New Response Object
        response_object heroku_response;

        //Generate Contact and Account JSON
        String contact_and_account_JSON = JSON.serializePretty(c);

        //Set params for endpoint resource URL
        this.api_version = '/v1';
        this.resource = '/sf';

        //Init ACS Request
        Hotrod_Request new_hotrod_request = this.hotrod_request;
        new_hotrod_request.set_end_platform('HEROKU');
        new_hotrod_request.set_endpoint(this.heroku_http,this.heroku_environemnt+this.api_version+this.resource);
        new_hotrod_request.set_http_method('POST');
        new_hotrod_request.set_body(contact_and_account_JSON);
        heroku_response = generate_response_object(new_hotrod_request.callout());


        return heroku_response;
    }

    public response_object new_dealer(Id account_id){
        //Get Account
        Account a = [SELECT Id, Phone, Website, Email__c, Name, Account_ID__c, ShippingCity ,ShippingStreet ,ShippingPostalCode, Status__c FROM Account WHERE Id = :account_id];

        //Init New Response Object
        response_object heroku_response;

        //Generate Contact and Account JSON
        String contact_and_account_JSON = JSON.serializePretty(a);

        //Set params for endpoint resource URL
        this.api_version = '/v1';
        this.resource = '/sf';

        //Init ACS Request
        Hotrod_Request new_hotrod_request = this.hotrod_request;
        new_hotrod_request.set_end_platform('HEROKU');
        new_hotrod_request.set_endpoint(this.heroku_http,this.heroku_environemnt+this.api_version+this.resource);
        new_hotrod_request.set_http_method('POST');
        new_hotrod_request.set_body(contact_and_account_JSON);
        heroku_response = generate_response_object(new_hotrod_request.callout());
        system.debug(new_hotrod_request);

        return heroku_response;
    }

    public response_object update_dealer(Id account_id){
        //Get Account
        Account a = [SELECT Id, Phone, Website, Email__c, Name, Account_ID__c, ShippingCity ,ShippingStreet ,ShippingPostalCode, Status__c FROM Account WHERE Id = :account_id];

        //Init New Response Object
        response_object heroku_response;

        //Generate Contact and Account JSON
        String contact_and_account_JSON = JSON.serializePretty(a);

        //Set params for endpoint resource URL
        this.heroku_environemnt = 'hotrod-api-dev.herokuapp.com'; // ****This Will Chnage
        this.api_version = '/v1';
        this.resource = '/sf';

        //Init ACS Request
        Hotrod_Request new_hotrod_request = this.hotrod_request;
        new_hotrod_request.set_end_platform('HEROKU');
        new_hotrod_request.set_endpoint(this.heroku_http,this.heroku_environemnt+this.api_version+this.resource);
        new_hotrod_request.set_http_method('PUT');
        new_hotrod_request.set_body(contact_and_account_JSON);
        heroku_response = generate_response_object(new_hotrod_request.callout());


        return heroku_response;
    }

    public response_object new_subscription(){

        return null;
    }

    public response_object update_subscription(){
    	
        return null;
    }
    

    public class response_object {
        public Map<String,String> headers {get; set;}
        public String status {get; set;}
        public Integer status_code {get; set;}
        public Map<String,String> body  {get; set;}
        public String body_json {get; set;}
        public DateTime timestamp {get; set;}
        public Boolean success {get; set;}
        
        public void set_headers(Map<String,String> headers){
            this.headers = headers;
        }

        public void set_status(String status){
            this.status = status;
        }

        public void set_status_code(Integer status_code){
            this.status_code = status_code;
            this.success = (status_code == 200)?true:false;
        }

        public void set_body(String body){
            try{
                this.body = (Map<String,String>)JSON.deserialize(body, Map<String,String>.Class);
            }catch(exception e){
                this.body_json = body;
            }
        }

        public void set_timestamp(DateTime timestamp){
            this.timestamp = timestamp;
        }

        public response_object(){
            this.headers = new Map<String,String>();
        }
    }


    public response_object generate_response_object(HttpResponse http_heroku_response){

        response_object heroku_response = new response_object();

        //acs_response.set_headers(headers);
        heroku_response.set_status(http_heroku_response.getStatus());
        heroku_response.set_status_code(http_heroku_response.getStatusCode());
        heroku_response.set_body(http_heroku_response.getBody());
        heroku_response.set_timestamp(system.now());

        return heroku_response;
    }

}
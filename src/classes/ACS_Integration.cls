public with sharing class ACS_Integration { 

    private string acs_environemnt;
    private string acs_package;
    private string acs_method;
    private string acs_http;
    private ACS_Request acs_request;

    public ACS_Integration(){
        this.acs_environemnt = 'ni-acs-uat-auth.cloud-newsint.co.uk';
        this.acs_package = '';
        this.acs_method = '';
        this.acs_http = 'https://';
        this.acs_request = new ACS_Request();
    }

    public class acs_user_object {
        String tenantId;
        String username;
        String new_username;
        String password;
        String new_password;
        String timestamp;
        
        public acs_user_object(String t_id, String un, String new_un, String pw, String new_pw, String ts)
        {
            tenantId = t_id;
            username = un;
            new_username = new_un;
            password = pw;
            new_password = new_pw;
            timestamp = ts;
        }
    }

    public class acs_entitlement_object {
        String tenantId;
        String username;
        String password;
        String timestamp;
        
        public acs_entitlement_object(String t_id, String un, String pw, String ts)
        {
            tenantId = t_id;
            username = un;
            password = pw;
            timestamp = ts;
        }
    }

    public class response_object {
        public Map<String,String> headers {get; set;}
        public String status {get; set;}
        public Integer status_code {get; set;}
        public response_body body {get; set;}
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
            if(body != ''){
                try {
                    this.body = (response_body)JSON.deserialize(body, response_body.class);
                } catch (System.JSONException e) {
                    this.body = null;
                    system.debug('JSON Error: ' + e);
                }
            }
        }

        public void set_timestamp(DateTime timestamp){
            this.timestamp = timestamp;
        }

        public response_object(){
            this.headers = new Map<String,String>();
        }
    }

    // *** RESPONSE BODY STRUCTURE *** //

    public class response_body {
        public String tokenId;
        public String tokenIdExpiry;
        public String tenantId;
        public String username;
        public List<subscription> subscriptions;
        public Map<String,String> profiledata;

    }

    public class subscription {
        public String subscriptionId;
        public String entitlementStartDate;
        public String entitlementEndDate;
        public List<String> products;
    }



    // *** ACS METHODS *** //

    public response_object create_user(String tenant_id, String username, String password){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('username', username);
        gen.writeStringField('password', password);
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/authN';
        this.acs_method = '/createUser';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object update_user(String tenant_id, String username, String new_username){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('username', username);
        gen.writeStringField('newUsername', new_username);
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/authN';
        this.acs_method = '/updateUser';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object delete_user(String tenant_id, String username){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('username', username);
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/authN';
        this.acs_method = '/deleteUser';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object change_password(String tenant_id, String username, String old_password, String new_password){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeStringField('oldPassword', old_password);
        gen.writeStringField('newPassword', new_password);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/password';
        this.acs_method = '/changePassword';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }
    
    public response_object reset_password(String tenant_id, String username, String new_password, String confirm_password){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeStringField('newPassword', new_password);
        gen.writeStringField('confirmPassword', confirm_password);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/password';
        this.acs_method = '/forceResetPassword';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object set_one_time_password(String tenant_id, String username, String password){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeStringField('password', password);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/password';
        this.acs_method = '/setOneTimePassword';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object check_password_policy(String password){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('password', password);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/password';
        this.acs_method = '/checkPasswordPolicy';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }
    

    public response_object authenticate(String tenant_id, String username, String password, Integer remember_me, Integer saml_assertion){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeStringField('password', password);
        gen.writeNumberField('rememberMe', remember_me);
        gen.writeNumberField('samlAssertion', saml_assertion);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/authN';
        this.acs_method = '/authenticate';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }


    public response_object generate_login_cookie(String tenant_id, String token_id){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('tokenId', token_id);
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/authN';
        this.acs_method = '/generateLoginCookie';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }

    public response_object set_user_profile(String tenant_id, String username, String external_id, Map<String,String> profile_data){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeStringField('externalId', external_id);
        gen.writeFieldName('profileData');
        gen.writeStartObject();
        for (String key : profile_data.keySet()) {
            gen.writeFieldName(key);
            gen.writeString(profile_data.get(key));
        }
        gen.writeEndObject();
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();

        //Set params for endpoint resource URL
        this.acs_package = '/profile';
        this.acs_method = '/setUserProfile';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }


    public response_object set_user_entitlements(String tenant_id, String username, List<subscription> subscriptions){

        //Init New Response Object
        response_object acs_response;

        //Generate Dynamic JSON
        JSONGenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeStringField('tenantId', tenant_id);
        gen.writeStringField('username', username);
        gen.writeFieldName('subscriptions');
        gen.writeStartArray();
        for (subscription sub : subscriptions) {
            gen.writeStartObject();
            gen.writeStringField('subscriptionId', sub.subscriptionId);
            gen.writeStringField('entitlementStartDate', sub.entitlementStartDate);
            gen.writeStringField('entitlementEndDate', sub.entitlementEndDate);
            gen.writeObjectField('products', sub.products);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        gen.writeStringField('timestamp', system.now().formatGMT('yyyy-MM-dd\'T\'HH:m:ss\'Z\''));
        gen.writeEndObject();
        //Set params for endpoint resource URL
        this.acs_http = 'http://';
        this.acs_package = '/authZ';
        this.acs_method = '/setUserEntitlements';

        //Init ACS Request
        ACS_Request new_acs_request = this.acs_request;
        new_acs_request.set_endpoint(this.acs_http+this.acs_environemnt+this.acs_package+this.acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(gen.getAsString());
        acs_response = generate_response_object(new_acs_request.callout());

        return acs_response;
    }


    public response_object generate_response_object(HttpResponse http_acs_response){

        response_object acs_response = new response_object();

        Map<String,String> headers = new Map<String,String>();
        headers.put('X-NI-statusCode',http_acs_response.getHeader('X-NI-statusCode'));
        headers.put('X-NI-statusMessage',http_acs_response.getHeader('X-NI-statusMessage'));

        acs_response.set_headers(headers);
        acs_response.set_status(http_acs_response.getStatus());
        acs_response.set_status_code(http_acs_response.getStatusCode());
        acs_response.set_body(http_acs_response.getBody());
        acs_response.set_timestamp(system.now());

        return acs_response;
    }

    //One Time Password Generator

    public String generate_password(Integer len) {
        /*
        String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String numb = '0123456789';

        final Integer PW_LENGTH = 6;
        String pass = '';
        //for (Integer i = 0; i < PW_LENGTH; i++)
            //pass += chars.charAt(rnd.nextInt(chars.length()));
        return pass;
        */

        Blob blobKey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        List<String> chars = new List<String>{'a','b','c'};
        List<String> chars2 = new List<String>{'A','B','C'};
        Integer index = Math.mod(Math.abs(Crypto.getRandomInteger()),chars.size());
        Integer index2 = Math.mod(Math.abs(Crypto.getRandomInteger()),chars2.size());
        //Pattern.matches('[A-Za-z]', 'a')
        String aChar = chars[index];
        String bChar = chars2[index2];

        return aChar + bChar + key.substring(0,len);

    }

    //Set variables for testing
    public void set_test_mode(HttpResponse test_http_response) {
        this.acs_request.set_in_test(true);
        this.acs_request.set_test_http_response(test_http_response);
    }
}
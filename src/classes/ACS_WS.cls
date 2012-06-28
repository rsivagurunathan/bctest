@RestResource(urlMapping = '/v1/acs/*')
global with sharing class ACS_WS { 

    @HttpPost
    global static String post_to_acs() {

        //Variables
        String environemnt = 'https://ni-acs-uat-auth.cloud-newsint.co.uk'; 
        String acs_package = '';
        String acs_method = '';
        ACS_Request acs_request = new ACS_Request();

        //Get Parameters
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String acs_action_type = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        //Set params for endpoint resource URL
        if(acs_action_type == 'createUser'){
            acs_package = '/authN';
            acs_method = '/createUser';
        }else if(acs_action_type == 'updateUser'){
            acs_package = '/authN';
            acs_method = '/updateUser';   
        }else if(acs_action_type == 'setUserProfile'){
            acs_package = '/profile';
            acs_method = '/setUserProfile';   
        }else if(acs_action_type == 'getUserProfile'){
            acs_package = '/profile';
            acs_method = '/getUserProfile';   
        }

        //Init ACS Request
        ACS_Request new_acs_request = acs_request;
        new_acs_request.set_endpoint(environemnt+acs_package+acs_method);
        new_acs_request.set_end_platform('ACS');
        new_acs_request.set_http_method('POST');
        new_acs_request.set_body(req.requestBody.toString());
        HttpResponse acs_res = new_acs_request.callout();

        //Generate Dynamic JSON
        if(acs_res.getStatusCode() != 200 || acs_action_type != 'getUserProfile') {
            JSONGenerator gen = JSON.createGenerator(false);
            gen.writeStartObject();
            gen.writeStringField('X-NI-statusMessage', (acs_res.getHeader('X-NI-statusMessage') != null)?acs_res.getHeader('X-NI-statusMessage'):'');
            gen.writeStringField('X-NI-statusCode', (acs_res.getHeader('X-NI-statusCode') != null)?acs_res.getHeader('X-NI-statusCode'):'');
            gen.writeNumberField('ACS_Status', acs_res.getStatusCode());
            gen.writeEndObject();

            return gen.getAsString();
        }else{
            return acs_res.getBody();
        }
    }

    @HttpGet
    global static string get_from_acs() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        //Log Request
        system.debug(req.requestBody.toString());
        return 'Salesforce Received Your Get Request Successfully';
    }
    
}
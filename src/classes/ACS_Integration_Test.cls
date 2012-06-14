@isTest(seeAllData=true)
public class ACS_Integration_Test {
  
  @isTest(seeAllData=true)
    public static void user_test() {
        
        //Init New ACS Integration Object
        ACS_Integration h_acs = new ACS_Integration();

        //Init Response Object
        ACS_Integration.response_object acs_response;

        
        //Set Create User Response
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Create User
        acs_response = h_acs.create_user('TNL','acs_test@ni.com','TestTest21');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Update User Response
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Update User
        acs_response = h_acs.update_user('TNL','acs_test@ni.com','acs_test2@ni.com');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Password Policy Response
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Password Policy
        acs_response = h_acs.check_password_policy('TestTest22');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Change Password Response
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Change Password
        acs_response = h_acs.change_password('TNL','acs_test2@ni.com','TestTest21','TestTest22');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set User Profile
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Set User Profile
        Map<String,String> profile_data = new Map<String,String>();
        profile_data.put('iamId','123456');
        profile_data.put('firstName','abc');
        profile_data.put('lastName','zxc');
        profile_data.put('email','abc@newsint.co.uk');
        acs_response = h_acs.set_user_profile('TNL','acs_test2@ni.com','123456789',profile_data);
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set User Entitlements
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Set User Subscriptions
        List<ACS_Integration.subscription> subscriptions = new List<ACS_Integration.subscription>();
        ACS_Integration.subscription sub =  new ACS_Integration.subscription();
        sub.subscriptionId = '123456789';
        sub.entitlementStartDate = '2012-01-31T00:00:00Z';
        sub.entitlementEndDate = '2013-12-31T23:59:00Z';
        sub.products = new List<String>{'A','B','C'};
        subscriptions.add(sub);
        //Callout
        acs_response = h_acs.set_user_entitlements('TNL','acs_test2@ni.com',subscriptions);
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Authenticate Response
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Authenticate
        acs_response = h_acs.authenticate('TNL','acs_test2@ni.com','TestTest22',0,0);
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Generate Login Cookie Response
        res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"tokenId":"12899089982323232","tokenIdExpiry":"2012-31-01T16:30:00Z"}');
        h_acs.set_test_mode(res);
        //Generate Login Cookie
        System.debug('===> TOKEN ' + acs_response.body);
        //acs_response = h_acs.generate_login_cookie('TNL',acs_response.body.tokenId);
        acs_response = h_acs.generate_login_cookie('TNL','123456789');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);


        //Set One Time Password
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //One Time Password
        acs_response = h_acs.set_one_time_password('TNL','acs_test2@ni.com','TestTest212');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

        //Set Delete User Response
        res = new HttpResponse();
        res.setStatusCode(200);
        h_acs.set_test_mode(res);
        //Delete User
        acs_response = h_acs.delete_user('TNL','acs_test2@ni.com');
        //Check Status Code
        System.assertEquals(acs_response.status_code, 200);
        System.assertEquals(acs_response.success, true);

    }
}
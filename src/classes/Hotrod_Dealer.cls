public class Hotrod_Dealer{
    
    private Boolean test_mode;

    public void set_test_mode(Boolean test){
        this.test_mode = test;
    }

    public Hotrod_Dealer(){
        this.test_mode = false;
    }

    //**** PRIMARY CONTACT ****

    //Register New Primary Contact
    @future(callout=true)
    public static void register_primary_contact(Id contact_id){

        //Get Contact
        Contact c = [SELECT Id, email, firstname, lastname, ACS_Exception__c, Account.External_Id__c, acs_profile_update_completed__c, acs_password__c, acs_registration_completed__c, HRD_callout_in_progress__c FROM Contact WHERE Id = :contact_Id];

        // *** ACS Create New User ***
        if(!c.acs_registration_completed__c){
            //Init New ACS Integration Object
            ACS_Integration h_acs = new ACS_Integration();

            //Init Response Object
            ACS_Integration.response_object acs_response;

            //Generate a Temporary Password
            String password = h_acs.generate_password(8);

            //Check if test mode
            if(Test.isRunningTest()){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                h_acs.set_test_mode(res);
            }

            //Create new user call
            acs_response = h_acs.create_user('HRD',c.email,password);

            if(acs_response.success){
                c.acs_password__c = password;
                c.acs_registration_completed__c = true;
            }else{
                c.acs_registration_completed__c = false;
                c.ACS_Exception__c = acs_response.headers.get('X-NI-statusMessage');
            }
        }

        // *** ACS Update User Profile ***
        if(!c.acs_profile_update_completed__c){
            //Init New ACS Integration Object
            ACS_Integration h_acs = new ACS_Integration();

            //Init Response Object
            ACS_Integration.response_object acs_response;

            //Check if test mode
            if(Test.isRunningTest()){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                h_acs.set_test_mode(res);
            }

            //Set External ID
            String external_id = (c.Account.External_Id__c != null)?c.Account.External_Id__c:String.valueOf((math.round(math.random()*1000000)));

            //Set User Profile
            Map<String,String> profile_data = new Map<String,String>();
            profile_data.put('firstName',c.firstname);
            profile_data.put('lastName',c.lastname);
            profile_data.put('email',c.email);
            acs_response = h_acs.set_user_profile('HRD',c.email,external_id,profile_data);

            if(acs_response.success){
                c.acs_profile_update_completed__c = true;
            }else{
                c.acs_profile_update_completed__c = false;
                c.ACS_Exception__c = acs_response.headers.get('X-NI-statusMessage');
            }

        }

        //Update Contact
        c.HRD_callout_in_progress__c = false;
        update c;
    }


    //Suspend Primary Contact
    @future(callout=true)
    public static void update_primary_contact(Id contact_id){
        //Get Contact
        Contact c = [SELECT Id, email, firstname, lastname, ACS_Exception__c, Registration_Email_Sent__c, Account.External_Id__c, acs_profile_update_completed__c, acs_password__c, acs_registration_completed__c, HRD_callout_in_progress__c FROM Contact WHERE Id = :contact_Id];

        if(c.acs_registration_completed__c){
            //Init New ACS Integration Object
            ACS_Integration h_acs = new ACS_Integration();

            //Init Response Object
            ACS_Integration.response_object acs_response;

            //Check if test mode
            if(Test.isRunningTest()){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                h_acs.set_test_mode(res);
            }

            //Set External ID
            String external_id = (c.Account.External_Id__c != null)?c.Account.External_Id__c:String.valueOf((math.round(math.random()*1000000)));

            //Set User Profile
            Map<String,String> profile_data = new Map<String,String>();
            profile_data.put('firstName',c.firstname);
            profile_data.put('lastName',c.lastname);
            profile_data.put('email',c.email);
            acs_response = h_acs.set_user_profile('HRD',c.email,external_id,profile_data);

            //Update Contact
            c.HRD_callout_in_progress__c = false;
            update c;
        }

    }

    //Suspend Primary Contact
    @future(callout=true)
    public static void delete_primary_contact(Id contact_id){
        
        //Get Contact
        Contact c = [SELECT Id, email, firstname, lastname, ACS_Exception__c, Registration_Email_Sent__c, Account.External_Id__c, acs_profile_update_completed__c, acs_password__c, acs_registration_completed__c, HRD_callout_in_progress__c FROM Contact WHERE Id = :contact_Id];

        if(c.acs_registration_completed__c){
            //Init New ACS Integration Object
            ACS_Integration h_acs = new ACS_Integration();

            //Init Response Object
            ACS_Integration.response_object acs_response;

            //Check if test mode
            if(Test.isRunningTest()){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                h_acs.set_test_mode(res);
            }

            //Create new user call
            acs_response = h_acs.delete_user('HRD',c.email);

            c.acs_registration_completed__c = acs_response.success;

            if(acs_response.success){
                c.acs_registration_completed__c = false;
                c.acs_profile_update_completed__c = false;
                c.Registration_Email_Sent__c = false;
            }else{
                c.ACS_Exception__c = acs_response.headers.get('X-NI-statusMessage');
            }
        }

        //Update Contact
        c.HRD_callout_in_progress__c = false;
        update c;

    }

    //Suspend Primary Contact
    @future(callout=true)
    public static void inactivate_primary_contact(Id contact_id){
        
        //Call Heroku 

    }

    //Change Primary Contact Email
    @future(callout=true)
    public static void change_primary_contact_email(Id contact_id, String old_email){

        //Get Contact
        Contact c = [SELECT Id, email, firstname, lastname, ACS_Exception__c, Account.External_Id__c, acs_profile_update_completed__c, acs_password__c, acs_registration_completed__c FROM Contact WHERE Id = :contact_Id];

        //Call ACS

        //Init New ACS Integration Object
        ACS_Integration h_acs = new ACS_Integration();

        //Init Response Object
        ACS_Integration.response_object acs_response;

        //Check if test mode
        if(Test.isRunningTest()){
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            h_acs.set_test_mode(res);
        }

        //Create new user call
        acs_response = h_acs.update_user('HRD',old_email,c.email);

        if(acs_response.success){

            //Update Profile

            //Init New ACS Integration Object
            ACS_Integration h_acs_update = new ACS_Integration();

            //Init Response Object
            ACS_Integration.response_object acs_response_update;

            //Check if test mode
            if(Test.isRunningTest()){
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                h_acs_update.set_test_mode(res);
            }

            //Set External ID
            String external_id = (c.Account.External_Id__c != null)?c.Account.External_Id__c:String.valueOf((math.round(math.random()*1000000)));

            //Set User Profile
            Map<String,String> profile_data = new Map<String,String>();
            profile_data.put('firstName',c.firstname);
            profile_data.put('lastName',c.lastname);
            profile_data.put('email',c.email);
            acs_response_update = h_acs_update.set_user_profile('HRD',c.email,external_id,profile_data);

            //Update Contact
            c.HRD_callout_in_progress__c = false;
            update c;
            
        }else{
            //Update Contact
            c.ACS_Exception__c = acs_response.headers.get('X-NI-statusMessage');
            c.HRD_callout_in_progress__c = false;
            update c;
        }   

        
    }

    //Reset Primary Contact Password
    @future(callout=true)
    public static void reset_primary_contact_password(Id contact_id){
    
        //Get Contact
        Contact c = [SELECT Id, email, firstname, lastname, ACS_Exception__c, Generate_Reset_Password_Email__c, Account.External_Id__c, acs_profile_update_completed__c, acs_password__c, acs_registration_completed__c FROM Contact WHERE Id = :contact_Id];

        //Call ACS

        //Init New ACS Integration Object
        ACS_Integration h_acs = new ACS_Integration();

        //Init Response Object
        ACS_Integration.response_object acs_response;

        //Generate a Temporary Password
        String password = h_acs.generate_password(8);

        //Check if test mode
        if(Test.isRunningTest()){
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            h_acs.set_test_mode(res);
        }

        //Create new user call
        acs_response = h_acs.reset_password('HRD',c.email,password,password);

        if(acs_response.success){
            c.acs_password__c = password;
            c.Generate_Reset_Password_Email__c = true;
            c.HRD_callout_in_progress__c = false;
        }else{
            c.ACS_Exception__c = acs_response.headers.get('X-NI-statusMessage');
        }
            
        //Update Contact
        update c;
    }

    //Login as Primary Contact
    @future(callout=true)
    public static void login_as_primary_contact(Id contact_id){
        
        //Generate a Temporary Password

        //Set Temp Password In ACS

        //Redirect User to the Front End Website

    }

    //Deactivate Primary Contact
    @future(callout=true)
    public static void deactivate_primary_contact(Id contact_id){
        
        //Call Heroku

    }


    //**** DEALER ****


    //Create new dealer
    @future(callout=true)
    public static void create_new_dealer(Id account_id){
        
        //Call Heroku

        //Get Account
        Account a = [SELECT Id, heroku_last_sync__c, External_ID__c FROM Account WHERE Id = :account_id];

        //Send Heroku Contact and Account Details
        Hotrod_Heroku h_heroku = new Hotrod_Heroku();

        //Init Response Object
        Hotrod_Heroku.response_object heroku_response;

        //Push new dealer info to Heroku
        heroku_response = h_heroku.new_dealer(a.id);

        if(heroku_response.success){
            a.heroku_last_sync__c = system.now();
            //Get Heroku GUID
            try{
                a.External_ID__c = heroku_response.body.get('GUID');
            }catch(exception e){
                a.External_ID__c = 'NO GUID';
            }
        }


        update a;

    }


    //Update existing dealer
    @future(callout=true)
    public static void update_existing_dealer(Id account_id){
        
        //Call Heroku

        //Get Account
        Account a = [SELECT Id, heroku_last_sync__c FROM Account WHERE Id = :account_id];

        //Send Heroku Contact and Account Details
        Hotrod_Heroku h_heroku = new Hotrod_Heroku();

        //Init Response Object
        Hotrod_Heroku.response_object heroku_response;

        //Push new dealer info to Heroku
        heroku_response = h_heroku.update_dealer(account_id);

        if(heroku_response.success){
            a.heroku_last_sync__c = system.now();
        }

        update a;

    }

}
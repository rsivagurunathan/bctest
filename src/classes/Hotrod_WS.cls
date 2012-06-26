@RestResource(urlMapping = '/v1/hrd/*')
global with sharing class Hotrod_WS { 


    @HttpPost
    global static String post_information() {
        
        //Get Request
        RestRequest req = RestContext.request;

        String hrd_action_type = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        if(hrd_action_type == 'newDealer'){

            //Init a List of parameter maps
            Map<String,String> json_param_map = new Map<String,String>();
            //Deserialize incoming JSON
            json_param_map = (Map<String,String>)JSON.deserialize(req.requestBody.toString(), Map<String,String>.class);


            Account a = new Account();
            a.Name = json_param_map.get('Name');
            a.External_Id__c = json_param_map.get('ExternalId');
            a.BillingCity = json_param_map.get('BillingCity');
            a.BillingStreet = json_param_map.get('BillingStreet');
            a.BillingPostalCode = json_param_map.get('BillingPostalCode');
            Database.insert(a);

            Contact c = new Contact();
            c.FirstName = json_param_map.get('FirstName');
            c.LastName = json_param_map.get('LastName');
            c.AccountID = a.Id;
            c.Email = json_param_map.get('Email');
            c.Primary_Contact__c = true;
            c.ACS_Registration_Completed__c = true;
            c.ACS_Profile_Update_Completed__c = true;
            c.Registration_Email_Sent__c = true;
            Database.insert(c);
            
            //Generate Response JSON
            
            String gen_account_id = a.name.substring(0, 2).toUpperCase() + String.valueOf(system.now()).substring(2, 4) + '-'+ String.valueOf(a.id).substring(0, 4);
            gen_account_id = (gen_account_id == null)?'null':gen_account_id;
            
            JSONGenerator gen = JSON.createGenerator(false);
            gen.writeStartObject();
            gen.writeStringField('Account_ID', gen_account_id);
            gen.writeEndObject();

            return gen.getAsString();

        }else if(hrd_action_type == 'listings'){

            
            //Init a List of car listings to be inserted
            List<Listings__c> car_listings = new List<Listings__c>();
            //Init a List of parameter maps
            List<Map<String,String>> json_param_map = new List<Map<String,String>>();
            //Deserialize incoming JSON
            json_param_map = (List<Map<String,String>>)JSON.deserialize(req.requestBody.toString(), List<Map<String,String>>.class);
            //Get Account Ids for Listing Lookup
            Set<String> external_ids = new Set<String>();
            for(Integer i = 0; i < json_param_map.size(); i++){
                external_ids.add(json_param_map[i].get('Account_ID'));
            }
            List<Account> accounts_for_listings = [SELECT Id, Account_Id__c FROM Account WHERE Account_Id__c IN :external_ids];
            //Get Assets
            List<Asset> assets_for_listings = [SELECT Id, Account__c, Account__r.Account_Id__c FROM Asset WHERE Account__r.Account_Id__c IN :external_ids];
            //Create Listings
            for(Integer i = 0; i < json_param_map.size(); i++){

                Listings__c car_listing = new Listings__c();

                car_listing.Active_Listings__c = Decimal.valueOf(json_param_map[i].get('Active_Listings'));
                car_listing.New_Listings__c = Decimal.valueOf(json_param_map[i].get('New_Listings'));
                //Link Account
                for(Account a :accounts_for_listings){
                    if(a.Account_Id__c == json_param_map[i].get('Account_ID')){
                        car_listing.Account_Name__c = a.Id;
                    }
                }
                //Link Asset
                for(Asset a :assets_for_listings){
                    if(a.Account__r.Account_Id__c == json_param_map[i].get('Account_ID')){
                        car_listing.Asset__c = a.Id;
                    }
                }

                if(car_listing.Asset__c != null){
                    car_listings.add(car_listing);
                }
            }
            if(!car_listings.isEmpty()){
                Database.insert(car_listings);
            }
            return 'Listings Created.';
        }else{
            return 'Resource Does Not Exist.';
        }
    }

    @HttpGet
    global static string get_information() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        //Log Request
        system.debug(req.requestBody.toString());
        return 'Salesforce Received Your Get Request Successfully';
    }
    
}
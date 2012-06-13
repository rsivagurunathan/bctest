trigger Hotrod_Primary_Contact on Contact (after insert, after update, before update) {

    //Contact For Update
    List<Contact> contact_for_update = new List<Contact>(); 

    if(Trigger.isAfter){
        //New Primary Contact Registration
        if(Trigger.isInsert){
            //This will limit how many primary contact can be registered at one time
            Integer processing_count_limit = 0; 
            for(Contact c : [SELECT Id, primary_contact__c, HRD_callout_in_progress__c, Heroku_Update_Completed__c, ACS_Registration_Completed__c, ACS_Profile_Update_Completed__c, Account.External_Id__c FROM Contact WHERE Id IN :Trigger.New]){
                if(c.primary_contact__c && processing_count_limit <= 10){
                    try{
                        Hotrod_Dealer.register_primary_contact(c.Id);
                        c.HRD_callout_in_progress__c = true;
                        contact_for_update.add(c);
                    }catch(Exception e){ 
                        system.debug(e);
                    }
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                }
            }
        //Existing Contact Set to be Primary Registration
        }else if(Trigger.isUpdate){

            //This will limit how many primary contact can be registered at one time && (!c.Heroku_Update_Completed__c || !c.ACS_Registration_Completed__c || !c.ACS_Profile_Update_Completed__c)
            Integer processing_count_limit = 0;
             
            for (Integer i = 0; i < Trigger.new.size(); i++) {
                //Activate Primary Contact Access
                if(!System.Trigger.old[i].primary_contact__c && System.Trigger.new[i].primary_contact__c && processing_count_limit <= 10 && !System.Trigger.new[i].HRD_callout_in_progress__c){
                    try{
                        Hotrod_Dealer.register_primary_contact(System.Trigger.new[i].Id);
                        Contact c = new Contact(Id = System.Trigger.new[i].Id);
                        c.HRD_callout_in_progress__c = true;
                        contact_for_update.add(c);
                    }catch(Exception e){ 
                        system.debug(e);
                    }
                    
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                //Delete Primary Contact Access
                }else if(System.Trigger.old[i].primary_contact__c && !System.Trigger.new[i].primary_contact__c && processing_count_limit <= 10 && !System.Trigger.new[i].HRD_callout_in_progress__c){
                    try{
                        Hotrod_Dealer.delete_primary_contact(System.Trigger.new[i].Id);
                        Contact c = new Contact(Id = System.Trigger.new[i].Id);
                        c.HRD_callout_in_progress__c = true;
                        contact_for_update.add(c);
                    }catch(Exception e){ 
                        system.debug(e);
                    }
                    
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                //Update Primary Contact Email
                }else if((System.Trigger.old[i].Email != System.Trigger.new[i].Email) && processing_count_limit <= 10 && !System.Trigger.new[i].HRD_callout_in_progress__c && System.Trigger.new[i].primary_contact__c){
                    try{
                        Hotrod_Dealer.change_primary_contact_email(System.Trigger.new[i].Id,System.Trigger.old[i].Email);
                        Contact c = new Contact(Id = System.Trigger.new[i].Id);
                        c.HRD_callout_in_progress__c = true;
                        contact_for_update.add(c);
                    }catch(Exception e){ 
                        system.debug(e);
                    }
                    
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                //Update Primary Contact 
                }else if((System.Trigger.old[i].FirstName != System.Trigger.new[i].FirstName) && (System.Trigger.old[i].LastName != System.Trigger.new[i].LastName) && System.Trigger.new[i].primary_contact__c && processing_count_limit <= 10 && !System.Trigger.new[i].HRD_callout_in_progress__c && ){
                    try{
                        Hotrod_Dealer.update_primary_contact(System.Trigger.new[i].Id);
                        Contact c = new Contact(Id = System.Trigger.new[i].Id);
                        c.HRD_callout_in_progress__c = true;
                        contact_for_update.add(c);
                    }catch(Exception e){ 
                        system.debug(e);
                    }
                    
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                }
            }

        }

        //Update Contacts that ar Being Registered
        if(!contact_for_update.isEmpty()){
            update contact_for_update;
        }

        //Update Username
        
    
    }
}
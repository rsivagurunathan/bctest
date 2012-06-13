trigger HRD_Account_Sync on Account bulk (after insert, after update) {
    
    if(Trigger.isInsert){
        try{
            //This will limit how many primary contact can be registered at one time
            Integer processing_count_limit = 0;
            for(Account a : Trigger.new){
                if(a.Asset_Generated__c && processing_count_limit <= 10){
                    //Call Heroku
                    Hotrod_Dealer.create_new_dealer(a.id);
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                }
            }
            
        }catch(Exception e){ system.debug(e);}
        
    }else if(Trigger.isUpdate){
        try{
            //This will limit how many primary contact can be registered at one time
            Integer processing_count_limit = 0;
            for(Account a : Trigger.new){
                if(a.Asset_Generated__c && processing_count_limit <= 10){
                    //Call Heroku
                    Hotrod_Dealer.create_new_dealer(a.id);
                    //Increment Count To avoid Governer Limit Exceptions
                    processing_count_limit++;
                }
            }
            
        }catch(Exception e){ system.debug(e);}
        
    }
    
}
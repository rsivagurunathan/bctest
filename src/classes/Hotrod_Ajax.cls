global class Hotrod_Ajax { 
  webService static void add_all_subsidiaries(String Id) {
         Id parrent_account = [SELECT Id, AccountId FROM Contract WHERE Id =:Id].AccountId;
         Account[] accounts = [SELECT Id FROM Account WHERE ParentId = :parrent_account];
         
         Contract_Locations__c[] contract_locations = new Contract_Locations__c[]{};
         
         for(Account account: accounts){
             Contract_Locations__c contract_location = new Contract_Locations__c();
             contract_location.Account_Name__c = account.Id;
             contract_location.Contract_Number__c = Id;
             contract_locations.add(contract_location);
         }
         
         if(!contract_locations.isEmpty()){
             insert contract_locations;
         }
    }
}
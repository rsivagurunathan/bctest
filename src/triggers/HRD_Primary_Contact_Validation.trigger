trigger HRD_Primary_Contact_Validation on Contact (before insert, before update) {
    
    List<Contact> account_contacts = new List<Contact>();
    Set<String> account_ids = new Set<String>();
    
    for (Integer i = 0; i < Trigger.new.size(); i++) {
        account_ids.Add(System.Trigger.new[i].AccountId);
    }
    
    if(!account_ids.isEmpty()){
        account_contacts = [SELECT Id, FirstName, LastName, AccountId, Primary_Contact__c FROM Contact WHERE Primary_Contact__c = true AND AccountId IN :account_ids];
    
        for(Contact c : Trigger.New){
            for(Contact c2 : account_contacts){
                if(c.id != c2.id && c.Primary_Contact__c == true && c.AccountId == c2.AccountId){
                    String fName = (c2.FirstName == null)?'':c2.FirstName;
                    c.addError(fName + ' ' + c2.LastName + ' is already the Primary Contact for this Account');
                }
            }
        }
    }
}
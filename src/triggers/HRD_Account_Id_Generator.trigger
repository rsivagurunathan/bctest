trigger HRD_Account_Id_Generator on Account (before insert) {  
    for(Account account : Trigger.New){
        //Blob blobKey = crypto.generateAesKey(128);
        String key = String.valueOf(Math.random());
        account.Acc_ID__c = account.name.substring(0, 2).toUpperCase() + String.valueOf(system.now()).substring(2, 4) + '-'+ key.substring(2,8);     
    }
}
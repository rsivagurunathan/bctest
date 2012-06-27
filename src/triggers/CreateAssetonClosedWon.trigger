trigger CreateAssetonClosedWon on Opportunity (after insert, after update) {
     for(Opportunity o: trigger.new){ 
      if(o.isWon == true && o.HasOpportunityLineItem == true){
         String opptyId = o.Id;
         OpportunityLineItem[] OLI = [Select UnitPrice, Usage__c, Agreed_Monthly_Price__c,  Quantity, PricebookEntry.Product2Id, PricebookEntry.Product2.Name, Description, Converted_to_Asset__c  
                                      From OpportunityLineItem 
                                      where OpportunityId = :opptyId  and Converted_to_Asset__c = false];
         Asset[] ast = new Asset[]{};
         //Account Assets
         Asset a_account = new Asset();
         Asset a_contract = new Asset();
         for(OpportunityLineItem ol: OLI){
            //New Accoun Asset
            a_account = new Asset();
            a_account.AccountId = o.AccountId;
                a_account.Product2Id = ol.PricebookEntry.Product2Id;
                a_account.Agreed_Monthly_Price__c = ol.Agreed_Monthly_Price__c;
                a_account.Agreed_Monthly_Usage__c = ol.Usage__c;
                a_account.Quantity = ol.Quantity;
                a_account.Price =  ol.UnitPrice;
                a_account.PurchaseDate = o.CloseDate;
                a_account.Status = 'Purchased';
                a_account.Description = ol.Description;
                a_account.Name = ol.PricebookEntry.Product2.Name;
            ast.add(a_account);
            
            //New Contract Asset
            a_contract = new Asset();
            a_contract.AccountId = o.AccountId;
            a_contract.Contract_Number__c = o.Contract_Number__c;
                a_contract.Product2Id = ol.PricebookEntry.Product2Id;
                a_contract.Agreed_Monthly_Price__c = ol.Agreed_Monthly_Price__c;
                a_contract.Agreed_Monthly_Usage__c = ol.Usage__c;
                a_contract.Quantity = ol.Quantity;
                a_contract.Price =  ol.UnitPrice;
                a_contract.PurchaseDate = o.CloseDate;
                a_contract.Status = 'Purchased';
                a_contract.Description = ol.Description;
                a_contract.Name = ol.PricebookEntry.Product2.Name;
            ast.add(a_contract);
            
            
            ol.Converted_to_Asset__c = true;
        }
        
        update OLI; 
        insert ast;
     }
   }
}
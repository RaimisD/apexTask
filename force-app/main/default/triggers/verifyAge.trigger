trigger verifyAge on Contact (before insert, before update) {
    Date today = Date.today();
    Date legalAgeDefault = Date.today() - 18;
    Date legalAgeUS = Date.today() - 21;

    for(Contact addContact : Trigger.new){
        if(addContact.Birthdate != null){
            //List<Account> relatedAccount = new List<Account>();
            Account relatedAccount = [SELECT Id, Country__c FROM Account WHERE Id =: addContact.AccountId LIMIT 1];
            if(relatedAccount.Country__c == 'US'){
                if(addContact.Birthdate < legalAgeUS){
                    addContact.addError('All contact persons should be of legal age.');
                }
            }else{
                if(addContact.Birthdate < legalAgeDefault){
                    addContact.addError('All contact persons should be of legal age.');
                }
            }
        }
    }
}
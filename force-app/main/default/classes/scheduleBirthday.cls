global class scheduleBirthday implements Schedulable{
    global void execute(SchedulableContext SC){
        List<Task> tasksToCreate = new List<Task>();
        List<Contact> upcomingBDayContacts = new List<Contact>();
        Date today = Date.today();
        Date targetDate = today.addDays(2);

        upcomingBDayContacts = [SELECT Id, Name, Birthdate, OwnerId, AccountId, Account.Name, Account.Industry, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry
        FROM Contact
        WHERE Birthdate =: targetDate];

        if(upcomingBDayContacts != null){
            for(Contact cont : upcomingBDayContacts){
                Integer age = targetDate.year() - cont.Birthdate.year();
                String comments;
                if(cont.MailingAddress == null){
                    comments = 'The mailing address is unknown. This Contact is an employee of '+cont.Account.Name+', part of the '+cont.Account.Industry+' Industry. Consider making an appropriate gift. Today is the Birthdate of '+cont.Name+'. He/She is now '+Age+' years old.';
                }else{
                    comments = 'The Mailing Address of the Contact is: '+cont.MailingAddress+' This Contact is an employee of '+cont.Account.Name+', part of the '+cont.Account.Industry+' Industry. Consider making an appropriate gift. Today is the Birthdate of '+cont.Name+'. He/She is now '+Age+' years old.';
                }
                Task newTask = new Task(
                    WhatId = cont.AccountId, //related
                    OwnerId = cont.OwnerId, //owner
                    Subject = cont.Name + ' Birthdate', //subject
                    ActivityDate = cont.Birthdate, //duedate
                    Priority = 'Low',
                    Description = comments
                );
                tasksToCreate.add(newTask);
            }
            if(!tasksToCreate.isEmpty()){
                insert tasksToCreate;
            }
        }
    }
}
/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class TaskClass2 implements Queueable {

        private List<Account> accounts;
 //[SELECT Id, (SELECT Id, Is_Synced__c, Processed_By_Queue__c FROM Contacts)
    //                                    FROM Account WHERE BillingCity != '' OR BillingCountry != '' OR BillingPostalCode != '']
        public TaskClass2(List<Account> accounts) {
            this.accounts = accounts;
    }
    public void execute(QueueableContext context) {

        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            for (Contact contact : account.Contacts) {
                contact.Is_Synced__c = false;
                contact.Processed_By_Queue__c = true;
                contacts.add(contact);
            }
        }
        update contacts;
    }

}
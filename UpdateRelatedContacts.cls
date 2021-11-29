/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class UpdateRelatedContacts implements Queueable {

    private List<Account> accounts;

    public UpdateRelatedContacts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public void execute(QueueableContext context) {

        Map<Id, Account> mapAccount = new Map<Id, Account>(accounts);
        List<Id> listAccountId = new List<Id>(mapAccount.keySet());

        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :listAccountId];

        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
        }

        update contacts;
    }

}
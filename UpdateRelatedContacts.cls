/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class UpdateRelatedContacts implements Queueable {

    private List<Id> listAccountId;

    public UpdateRelatedContacts(List<Id> listAccountId) {
        this.listAccountId = listAccountId;
    }

    public void execute(QueueableContext context) {
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Queue__c FROM Contact WHERE AccountId IN :listAccountId];
        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
        }

        update contacts;
    }

}
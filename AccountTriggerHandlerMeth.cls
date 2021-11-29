/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class AccountTriggerHandlerMeth {

    public void function(Account[] accounts){
        System.debug('Trigger is run');
        //Integer recordCount = accounts.size();

        // Call a utility method from another class
        /*EmailManager.sendMail('elysiuk@gmail.com', 'Trailhead Trigger Tutorial',
                recordCount + ' account(s) were inserted.');*/
    }

}

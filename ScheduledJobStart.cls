/**
 * Created by Elena on 09.08.2021.
 */

public with sharing class ScheduledJobStart {

    public static String CRON_EXP1 = '0 0 * * * ?';

    public static String CRON_EXP2 = '0 30 * * * ?';

    public static void runFirst(){
        String jobID1 = System.schedule('ScheduledJobClass', CRON_EXP1, new ScheduledJobClass());
        String jobID2 = System.schedule('ScheduledJobClass', CRON_EXP2, new ScheduledJobClass());
    }

    public static void runSecond() {
        String jobID1 = System.schedule('TaskScheduledJob', CRON_EXP1, new TaskScheduledJob());
        String jobID2 = System.schedule('TaskScheduledJob', CRON_EXP2, new TaskScheduledJob());
    }

}
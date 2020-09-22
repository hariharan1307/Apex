public class CompletedTaskClass 
{
    public static void TriggerMethod(List<Task> TriggeredTasks)
    {
        List<Account> AcntsUpdated=new List<Account>();
        List<Id> AcntIds=new List<Id>();
        for(Task SingleRelatedtask:TriggeredTasks)
        { 
            AcntIds.add(SingleRelatedtask.WhatId);
        }
        List<Account> acntsWithTask=[select Id,First_Name__c,Last_Name__c from Account where Id in:AcntIds];
        List<Task> Tasks=[select Id,WhatId,Status from Task where AccountId in:AcntIds];
        for(Account acnts:acntsWithTask )
        {
            List<Task> CompletedTask =new List<Task>();
            for(Task AllRelatedtask:Tasks)
            {
                if(AllRelatedtask.Status=='Completed')
                {
                    CompletedTask.add(AllRelatedtask);
                }    
            }
            if(CompletedTask.size()>0)
            {
                acnts.No_of_Tasks__c=CompletedTask.size();
                AcntsUpdated.add(acnts);
            }
            else
            {
                acnts.No_of_Tasks__c=0;
                AcntsUpdated.add(acnts);
            }
        }
        update AcntsUpdated;
    }
    
}

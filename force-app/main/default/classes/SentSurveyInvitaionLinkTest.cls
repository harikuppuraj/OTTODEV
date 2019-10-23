@isTest(SeeAllData=true)
public class SentSurveyInvitaionLinkTest {
    
    public static testMethod void testSurveyLink()
    {
        Test.startTest();
        List<SurveyInvitation> lstSurInv=new List<SurveyInvitation>();
        Contact cnt=new Contact();
        cnt.lastname='testlname';
        cnt.Email='test@gmail.com';
        insert cnt;
        Account act=new Account();
        act.name='testCustomer';
        act.Email__c='test@gmail.com';
        insert act;
        String SurveyId=[Select Id from Survey where DeveloperName='otto_logistic_survey'].Id;
        String CommunityId=[Select Id from Network where name='OnePak Partners'].Id;
        //srv.name='OTTO LOGISTICS SURVEY';
        //insert srv;
        SurveyInvitation objSrveyInv=new SurveyInvitation();
        objSrveyInv.name='test survey invitation';
        objSrveyInv.SurveyId=SurveyId;
        objSrveyInv.CommunityId=CommunityId;
        objSrveyInv.Contact__c=Cnt.Id;
        objSrveyInv.Customer__c=act.Id;
        //objSrveyInv.Survey;
        lstSurInv.add(objSrveyInv);
        insert lstSurInv;
        //List<String> SurvInvId=new List<String>();
        //SurvInvId.add(lstSurInv[0].Id);
        SentSurveyInvitaionLink.SentLink(new String[]{lstSurInv[0].Id});
        Test.stopTest();
        
    }
    
}
public class SentSurveyInvitaionLink {
    
    @InvocableMethod
    public static void SentLink(List<String> InvitationId)
    {
        String SyrveyInvitationId= InvitationId[0];
        system.debug('===SyrveyInvitationId==='+SyrveyInvitationId);
        List<SurveyInvitation> lstSurInvitation=[Select Id , 
                                                 name,
                                                 ParticipantId,
                                                 InvitationLink,
                                                 Contact__c, 
                                                 Contact__r.Personal_Email__c, 
                                                 Contact__r.Email, 
                                                 Contact__r.Name, 
                                                 Contact__r.Phone, 
                                                 Contact__r.HomePhone, 
                                                 Contact__r.OwnerId, 
                                                 Contact__r.MobilePhone, 
                                                 Customer__c,
                                                 Customer__r.Name,
                                                 Customer__r.Email__c,
                                                 Job__c, 
                                                 Job__r.Name, 
                                                 Survey.DeveloperName,
                                                 CommunityId,
                                                 community.Name,
                                                 UUID
                                                 from SurveyInvitation 
                                                 where Id =:SyrveyInvitationId];
        system.debug('===lstSurInvitation==='+lstSurInvitation[0]);
        List<EmailTemplate> eTemplate=[Select Id,DeveloperName, Name, Subject, HtmlValue 
                                       from Emailtemplate where DeveloperName = 'Survey_Template' Limit 1 ];
        system.debug('===eTemplate==='+eTemplate[0]);
        List<Messaging.SingleEmailMessage> emailnotifications=new List<Messaging.SingleEmailMessage>();
        system.debug('===eTemplate==='+eTemplate.size() +' '+lstSurInvitation.size()+' '+lstSurInvitation[0].Customer__r.Email__c);
        if(eTemplate.size()>0 && lstSurInvitation.size()>0
           && eTemplate[0].HtmlValue != null  
           && lstSurInvitation[0].Customer__r.Email__c != null)
        {
            Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
            List<String> toEmailAddress=new List<String>();
            List<String> toEmailBCCAddress=new List<String>();
            toEmailAddress.add(lstSurInvitation[0].Customer__r.Email__C);            
            email.setToAddresses(toEmailAddress);           
            email.setSubject(eTemplate[0].Subject);
            email.setHtmlBody(eTemplate[0].HtmlValue);
            email.setHtmlBody(email.getHtmlBody().replace('CONTACT_NAME',lstSurInvitation[0].Customer__r.Name));
            email.setHtmlBody(email.getHtmlBody().replace('SURVEY_LINK',lstSurInvitation[0].InvitationLink));
            emailnotifications.add(email);
            system.debug('===emailnotifications==='+emailnotifications);
            Messaging.sendEmail(emailnotifications);
        }
    }
    
}
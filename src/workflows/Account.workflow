<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Inform_GForces_of_changes_on_account</fullName>
        <description>Inform GForces of changes on account</description>
        <protected>false</protected>
        <recipients>
            <recipient>edith.sereno@driving.com.hotroddev</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hotrod_Email_Templates/Hotrod_Dealer_details_GForces_email</template>
    </alerts>
    <rules>
        <fullName>Account dealer shared with GForces</fullName>
        <actions>
            <name>Inform_GForces_of_changes_on_account</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>This WF sends GForces the details for the dealer when the account is created and/or updated.</description>
        <formula>IF( ISNEW(), TRUE, or( ISCHANGED( BillingCity ),  ISCHANGED( BillingStreet ) ,  ISCHANGED( BillingPostalCode )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Hotrod - Send Account Address Updated to SAP</fullName>
        <actions>
            <name>Generate_Account_Amendment_form</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>When an account address is updated, send the new information to SAP</description>
        <formula>or( ISCHANGED( BillingCity ) ,  ISCHANGED( BillingStreet ) ,  ISCHANGED( BillingPostalCode ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Generate_Account_Amendment_form</fullName>
        <assignedToType>owner</assignedToType>
        <description>Generate the account amendment form and send to finance@hotrod.com</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Generate Account Amendment form</subject>
    </tasks>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_the_account_owner_when_the_usage_limit_is_exceeded</fullName>
        <description>Email the account owner when the usage limit is exceeded</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hotrod_Email_Templates/Usage_Limit_Exceeded</template>
    </alerts>
    <rules>
        <fullName>Usage Limit Exceeded</fullName>
        <actions>
            <name>Email_the_account_owner_when_the_usage_limit_is_exceeded</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>When the dealer exceeds their usage limit, notify the sales rep to negotiate contract amendment.</description>
        <formula>AND(ISCHANGED(Discrepancy__c), Discrepancy__c&lt;&gt;0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Opportunity_approved</fullName>
        <description>Opportunity approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hotrod_Email_Templates/Classified_Approved_Opportunity</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_rejected</fullName>
        <description>Opportunity rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hotrod_Email_Templates/Classified_Rejected_Opportunity</template>
    </alerts>
    <fieldUpdates>
        <fullName>Account_Status_Active</fullName>
        <field>Status__c</field>
        <literalValue>Active</literalValue>
        <name>Account Status Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Approval_Required_TRUE</fullName>
        <description>Sets the value to TRUE when the value is TRUE on the product</description>
        <field>Approval_Required__c</field>
        <literalValue>1</literalValue>
        <name>Opp Approval Required TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Approval_Status_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Opp Approval Status &gt; Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Approval_Status_Pending</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Opp Approval Status &gt; Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Approval_Status_Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Opp Approval Status &gt; Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Approval_Status_Required</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approval Required</literalValue>
        <name>Opp Approval Status &gt; Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_RT_to_create_quote</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Create_Quote_Classified_Opportunity_RT</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Opp RT to create quote</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Additional Line Item - Approval Status Update</fullName>
        <actions>
            <name>Opp_Approval_Required_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opp_Approval_Status_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(ISNULL(Line_Item_count__c )),  PRIORVALUE(Line_Item_count__c )  &lt;&gt;  Line_Item_count__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Opp - Requires approval TRUE</fullName>
        <actions>
            <name>Opp_Approval_Required_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.HasOpportunityLineItem</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Approval_Status__c</field>
            <operation>notEqual</operation>
            <value>Approved,Rejected</value>
        </criteriaItems>
        <description>When the opportunity line item requires approval, the Requires approval on the opportunity is updated to be included in the approval process.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Account Status to Active</fullName>
        <actions>
            <name>Account_Status_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Type</field>
            <operation>notEqual</operation>
            <value>Competitor,Prospect,Agency</value>
        </criteriaItems>
        <description>When an opportunity is won for a new account, the status of this account is set to active</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Opportunity Record Type</fullName>
        <actions>
            <name>Update_Opp_RT_to_create_quote</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Quote_Expiry_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.QuoteEndDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.QuoteBeginDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

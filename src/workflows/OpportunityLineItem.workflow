<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Discount_to_approve</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approval Required</literalValue>
        <name>Discount to Approve</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Line_Item_Approval_Required_FALSE</fullName>
        <field>Approval_Required__c</field>
        <literalValue>0</literalValue>
        <name>Opp Line Item Approval Required FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opp_Line_Item_Approval_Required_TRUE</fullName>
        <description>Sets the value to TRUE when the value is TRUE on the product</description>
        <field>Approval_Required__c</field>
        <literalValue>1</literalValue>
        <name>Opp Line Item Approval Required TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_approved</fullName>
        <field>Approved__c</field>
        <literalValue>1</literalValue>
        <name>Product approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Discount to approve</fullName>
        <actions>
            <name>Discount_to_approve</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If a discount is &gt;10%, the opportunity must be approved before it is processed further</description>
        <formula>AND( $UserRole.Name &lt;&gt; &quot;Sales Director&quot;, Discount__c &gt;0.10)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Usage Limit Exceeded</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Asset.Discrepancy__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>When the dealer exceeds their usage limit, notify the sales rep to negotiate contract amendment.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

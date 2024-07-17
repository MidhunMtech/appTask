<cftry>
    <cfinvoke component="component.component" method="scheduleData" returnVariable="scheduleData">
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<cfschedule action="list" mode="server" result ="res" />
<cfset tasklist = valueList(res.task)/>

<cfloop query="scheduleData">
    <cfset date="#scheduleData.DOB#">
    <cfset day = day(date)> 
    <cfset month = month(date)>
    <cfset year = year(now())>
    <cfif month(now()) GT month OR (month(now()) EQ month AND day(now()) GT day)>
        <cfset year += 1>
    </cfif>
    <cfset myDate = CreateDate(year, month, day)>
    
    <cftry>
        <cfset name = "sendEmailTask#scheduleData.userId#" >
        <cfif scheduleData.is_delete EQ 0 >
            <cfschedule action="update"
                task="#name#"
                operation="HTTPRequest"
                url="http://appTask.local.com/scheduledTask/mail.cfm?id=#scheduleData.userId#"
                startDate="#myDate#"
                startTime="8:00 AM"
                interval="once">

        <cfelseif scheduleData.is_delete EQ 1 AND listFind(tasklist, "#name#")>
            <cfschedule action="delete" task="#name#">
        </cfif>
    <cfcatch type="any">
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfloop>
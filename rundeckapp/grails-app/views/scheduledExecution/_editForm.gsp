<%@ page import="com.dtolabs.rundeck.server.authorization.AuthConstants" %>

<g:render template="/common/errorFragment"/>
<auth:resourceAllowed kind="job" action="${AuthConstants.ACTION_DELETE}">
    <g:if test="${auth.jobAllowedTest(job: scheduledExecution, action: AuthConstants.ACTION_DELETE)}">
        <div class="panel panel-danger obs_delete_show" style="display:none; ">
            <div class="panel-heading">Delete <g:message code="domain.ScheduledExecution.title"/></div>

            <div id="${ukey}jobDisplayDeleteConf${scheduledExecution.id}" class="panel-body ">
                <g:form controller="scheduledExecution" action="delete" method="post">
                    <g:hiddenField name="id" value="${scheduledExecution.id}"/>
                    <g:render template="/scheduledExecution/showHead"
                              model="${[scheduledExecution: scheduledExecution, runPage: true]}"/>
                    <p class=" ">Really delete this <g:message
                            code="domain.ScheduledExecution.title"/>?</p>

                    <div class="buttons primary ">
                        <button type="submit" class="behavior_delete_hide btn btn-default btn-sm ">
                            Cancel
                        </button>
                        <input type="submit" value="Delete" class="btn btn-danger btn-sm"/>
                    </div>
                </g:form>
            </div>
        </div>
    </g:if>
</auth:resourceAllowed>
<g:form controller="scheduledExecution" method="post"
        class="form-horizontal"
        onsubmit="if(typeof(validateJobEditForm)=='function'){return validateJobEditForm(this);}">

<div class="panel panel-primary obs_delete_hide" id="editForm">
    <div class="panel-heading">
        <span class="h4">
            Edit <g:message code="domain.ScheduledExecution.title"/>
        </span>
    </div>



        <g:render template="edit" model="[scheduledExecution:scheduledExecution, crontab:crontab, command:command,authorized:authorized]"/>

        <div class="panel-footer">
            <div class="row">
            <div class="buttons col-sm-10">

                <g:actionSubmit id="editFormCancelButton" value="Cancel"
                                onclick="if(typeof(jobEditCancelled)=='function'){jobEditCancelled();}"
                                class="btn btn-default"/>
                <g:actionSubmit value="Save" action="Update" class="btn btn-primary "/>

            </div>
            <auth:resourceAllowed kind="job" action="${AuthConstants.ACTION_DELETE}">
                <g:if test="${auth.jobAllowedTest(job: scheduledExecution, action: AuthConstants.ACTION_DELETE)}">
                    <div class="  col-sm-2">
                        <span class="textbtn textbtn-danger pull-right behavior_delete_show"
                              title="Delete ${g.message(code: 'domain.ScheduledExecution.title')}">
                            <b class="glyphicon glyphicon-remove-circle"></b>
                            Delete this Job
                        </span>
                    </div>
                </g:if>
            </auth:resourceAllowed>
            </div>
        </div>


</div>

</g:form>
<g:javascript>
fireWhenReady('editForm',function(){
    $$('.behavior_delete_show').each(function(e){
        Event.observe(e,'click',function(evt){
            evt.stop();
            $$('.obs_delete_hide').each(Element.hide);
            $$('.obs_delete_show').each(Element.show);
        })
    });
    $$('.behavior_delete_hide').each(function(e){
        Event.observe(e,'click',function(evt){
            evt.stop();
            $$('.obs_delete_hide').each(Element.show);
            $$('.obs_delete_show').each(Element.hide);
        })
    });
});
</g:javascript>

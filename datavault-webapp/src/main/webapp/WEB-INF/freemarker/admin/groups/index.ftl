<#import "*/layout/defaultlayout.ftl" as layout>
<#-- Specify which navbar element should be flagged as active -->
<#global nav="admin">
<@layout.vaultLayout>

<div class="modal fade" id="confirm-removal" tabindex="-1" role="dialog" aria-labelledby="confirmRemovalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="confirmRemovalLabel">Confirm removal of group ownership</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to remove <b><i class="remove-user"></i></b> from the Owners of the <b><i class="remove-group"></i></b> group?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger btn-ok">Remove</button>
            </div>
        </div>
    </div>
</div>

<div class="container">

    <ol class="breadcrumb">
        <li><a href="${springMacroRequestContext.getContextPath()}/admin/"><b>Administration</b></a></li>
        <li class="active"><b>Groups</b></li>
    </ol>

    <#if groups?has_content>
        <div class="table-responsive">
            <table class="table table-striped">

                <thead>
                    <tr class="tr">
                        <th>ID</th>
                        <th>Name</th>
                        <th>Vaults</th>
                        <th>Owners</th>
                    </tr>
                </thead>

                <tbody>
                    <#assign counter = 0 >
                    <#list groups as group>
                        <tr class="tr">
                            <td>${group.ID?html}</td>
                            <td>${group.name?html}</td>
                            <td><span class="badge">${vaultCounts[counter]}<#assign counter = counter + 1></span></td>
                            <td>
                                <ul class="list-group">
                                    <#list group.getOwners() as user>
                                        <li class="list-group-item"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> ${user.name?html} (${user.getID()?html})
                                            <a class="btn btn-xs btn-danger pull-right" href="#" data-record-user="${user.getID()}" data-record-group="${group.ID}" data-toggle="modal" data-target="#confirm-removal">
                                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Remove
                                            </a>
                                        </li>
                                   </#list>
                                </ul>
                                <form>
                                    <a class="btn btn-default" href="${springMacroRequestContext.getContextPath()}/admin/groups/${group.ID}/add">
                                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Owner
                                    </a>
                                </form>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </#if>

    <form>
        <a class="btn btn-primary" href="${springMacroRequestContext.getContextPath()}/admin/groups/create">
            <span class="glyphicon glyphicon-education" aria-hidden="true"></span> Create new Group
        </a>
    </form>

</div>

<script>
    // Bind properties to the removal confirmation dialog
    $('#confirm-removal').on('show.bs.modal', function(e) {
        var data = $(e.relatedTarget).data();
        $('.remove-user', this).text(data.recordUser);
        $('.remove-group', this).text(data.recordGroup);
        $('.btn-ok', this).data('recordUser', data.recordUser, 'recordGroup', data.recordGroup);
    });
</script>

</@layout.vaultLayout>

<fieldset>
    <div class="form-card">
        <h2 class="fs-title">Summary</h2>
        <div>
            <table class="table table-sm">

                <tbody>
                <tr>
                    <th scope="col">Vault Name</th>
                    <td>
                        <@spring.bind "vault.name" />
                        ${spring.status.value!""}
                    </td>
                </tr>
                <tr>
                    <th scope="col">Description</th>
                    <td>
                        <@spring.bind "vault.description" />
                        ${spring.status.value!""}
                    </td>
                </tr>
                <tr>
                    <th scope="col">Estimate Size</th>
                    <td>
                        <@spring.bind "vault.estimate" />
                        ${spring.status.value!""}
                    </td>
                </tr>
                <tr>
                    <th scope="col">PURE ID</th>
                    <td>Not available yet (not sure it ever will be at this stage unless we can create the pure record in DV)</td>
                </tr>
                <tr>
                    <th scope="col">Grant End Date</th>
                    <td><@spring.bind "vault.grantEndDate" />
                        ${spring.status.value!""}
                    </td>
                </tr>
                <tr>
                    <th scope="col">Review Date</th>
                    <td><@spring.bind "vault.reviewDate" />
                        ${spring.status.value!""}
                    </td>
                </tr>
                <tr>
                    <th scope="col">Billing</th>
                    <td>${vault.getBillingAsString()}</td>
                </tr>
                <tr>
                    <th scope="col">Owner</th>
                    <td><@spring.bind "vault.vaultOwner" />
                        ${spring.status.value!""}</td>
                </tr>
                <tr>
                    <th scope="col">Named Data Manager</th>
                    <td>${vault.getNDMsAsString()}</td>
                </tr>
                <tr>
                    <th scope="col">Data Creators</th>
                    <td>${vault.getDataCreatorsAsString()}
                    </td>
                </tr>
                <tr>
                    <th scope="col">Depositors</th>
                    <td>${vault.getDepositorsAsString()}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div>
            Please make sure all information above is correct and click on confirm to process to your vault creation.
            Once a member of our staff validates your request you'll receive a confirmation email and be good to go!
        </div>
        <div class="alert alert-warning">
            <strong>PLEASE NOTE – this information will be public, and will be linked to the PI’s Pure profile.</strong>
            <div class="checkbox">
                <label>
                    <@spring.bind "vault.pureLink" />
                    <input type="hidden" name="_${spring.status.expression}" value="false"/>
                    <input id="pureLink-check" type="checkbox" name="${spring.status.expression}"
                           <#if spring.status.value?? && spring.status.value?string=="true">checked="true"</#if> /> I agree
                </label>
            </div>
        </div>
    </div>
    <button type="button" name="previous" class="previous action-button-previous btn btn-default" >&laquo; Previous</button>
    <button type="submit" name="save" value="Save" class="save action-button-previous btn btn-default" >
        <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> Save
    </button>
    <button type="submit" name="confirm" value="Confirm" class="action-button btn btn-success">
        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Confirm
    </button>
</fieldset>
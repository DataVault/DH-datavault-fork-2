package org.datavaultplatform.common.model.dao.custom;

import java.util.List;
import org.datavaultplatform.common.model.PendingVault;
import org.springframework.data.jpa.repository.EntityGraph;

public interface PendingVaultCustomDAO extends BaseCustomDAO {

    @EntityGraph(PendingVault.EG_PENDING_VAULT)
    List<PendingVault> list(String userId, String sort, String order, String offset, String maxResult);

    @EntityGraph(PendingVault.EG_PENDING_VAULT)
    List<PendingVault> search(String userId, String query, String sort, String order, String offset, String maxResult, String confirmed);

    int count(String userId);
    
    int getTotalNumberOfPendingVaults(String userId, String confirmed);

	  int getTotalNumberOfPendingVaults(String userId, String query, String confirmed);
}

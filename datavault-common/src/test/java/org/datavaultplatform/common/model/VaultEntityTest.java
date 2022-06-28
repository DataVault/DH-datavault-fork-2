package org.datavaultplatform.common.model;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;

@Slf4j
public class VaultEntityTest extends BaseEntityTest<Vault, String> {

  @Test
  void testEntity() {
    checkEntity(Vault.class, this::generateID);
  }
}

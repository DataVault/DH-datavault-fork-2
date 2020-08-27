create table PendingVaults (
    id varchar(36) not null,
    affirmed bit not null, billingType TEXT,
    creationTime datetime, description TEXT,
    estimate TEXT, grantEndDate date,
    name TEXT, notes TEXT, reviewDate date,
    sliceID TEXT,
    version bigint not null,
    group_id varchar(180),
    retentionPolicy_id integer,
    user_id varchar(36),
    primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

alter table PendingVaults add constraint FK1oqxrihj71uwiynk4m8u0n0vj foreign key (group_id) references Groups (id);
alter table PendingVaults add constraint FKtqmx003465315spj99suwf1ta foreign key (retentionPolicy_id) references RetentionPolicies (id);
alter table PendingVaults add constraint FKjj6cuk6m88qn7th5df64ui3cw foreign key (user_id) references Users (id);
ALTER TABLE Role_assignments ADD COLUMN pending_vault_id varchar(36) default null;
ALTER TABLE Role_assignments ADD CONSTRAINT `FK_Pending_Vault_ID` FOREIGN KEY (`pending_vault_id`) REFERENCES `PendingVaults` (`id`);
ALTER TABLE Role_assignments ADD UNIQUE KEY `UK_Pending_Vault_ID` (`role_id`,`user_id`,`pending_vault_id`);
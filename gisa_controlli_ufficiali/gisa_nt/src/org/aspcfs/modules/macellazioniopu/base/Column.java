package org.aspcfs.modules.macellazioniopu.base;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)

public @interface Column {

	String columnName();

	int columnType();

	String table();

}

package it.us.web.util.vam;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public final class QueryKey implements Serializable {

   private final String queryText;
   private final List queryParameters;

   public QueryKey(final String queryText, final List queryParameters) {
      this.queryText = queryText;
      this.queryParameters = queryParameters;
   }

   public String getQueryText() {
      return queryText;
   }

   public List getQueryParameters() {
      return Collections.unmodifiableList(queryParameters);
   }

   public boolean equals(final Object value) {
      if (this == value) return true;
      if (value == null || getClass() != value.getClass()) return false;
      final QueryKey query = (QueryKey)value;
      if (!queryParameters.equals(query.queryParameters)) return false;
      if (!queryText.equals(query.queryText)) return false;
      return true;
   }


   public int hashCode() {
      int result;
      result = queryText.hashCode();
      result = 29 * result + queryParameters.hashCode();
      return result;
   }
}
package it.us.web.util.jmesa;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.comparators.ComparatorChain;
import org.apache.commons.collections.comparators.NullComparator;
import org.jmesa.core.sort.ColumnSort;
import org.jmesa.limit.Limit;
import org.jmesa.limit.Order;
import org.jmesa.limit.Sort;
import org.jmesa.limit.SortSet;

public class CustomColumnSort implements ColumnSort 
{
    @SuppressWarnings("unchecked")
    public Collection<?> sortItems(Collection<?> items, Limit limit) 
    {
        ComparatorChain chain = new ComparatorChain();
        
//        Transformer transformer = new Transformer() 
//        {
//            public Object transform(Object input) 
//            {
//            	if(input==null)
//            		return input;
//            	if(input.getClass().toString().indexOf("Date")>=1)
//            		return ((Date)input);
//            	else
//            		return ((String)input).toLowerCase();
//            }
//        };
        
        //Comparator comparator = new TransformingComparator(transformer);
        
        
        SortSet sortSet = limit.getSortSet();
        for (Sort sort : sortSet.getSorts()) 
        {
            if (sort.getOrder() == Order.ASC) 
            	chain.addComparator(new BeanComparator(sort.getProperty() , new NullComparator(false) ));
            else if (sort.getOrder() == Order.DESC)
            	chain.addComparator(new BeanComparator(sort.getProperty() , new NullComparator(false) ),true);
        }

        if (chain.size() > 0) 
        {
            Collections.sort((List<?>) items, chain);
        }
        
        return items;
    }
}

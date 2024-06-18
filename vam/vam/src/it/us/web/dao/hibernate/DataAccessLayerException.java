package it.us.web.dao.hibernate;

public class DataAccessLayerException extends RuntimeException
{
	private static final long serialVersionUID = 8716196950416002586L;

	public DataAccessLayerException() {
    }

    public DataAccessLayerException(String message) {
        super(message);
    }

    public DataAccessLayerException(Throwable cause) {
        super(cause);
    }

    public DataAccessLayerException(String message, Throwable cause) {
        super(message, cause);
    }
}

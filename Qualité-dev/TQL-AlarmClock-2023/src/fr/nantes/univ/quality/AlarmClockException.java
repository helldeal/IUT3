package fr.nantes.univ.quality;
public class AlarmClockException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String msg;

	public AlarmClockException(String msg) {
		this.msg = msg;
	}

	public String toString() {
		return msg + " : " + super.toString();
	}

}
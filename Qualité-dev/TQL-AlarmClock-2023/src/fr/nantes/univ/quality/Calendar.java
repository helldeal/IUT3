package fr.nantes.univ.quality;

public class Calendar {

	public final static int HOUR = 1;
	public final static int MINUTE = 2;

	public Calendar() {
		super();
		System.out.println("A Calendar is instantiated");
	}

	public int get(int field) {
		System.out.println("Calendar consulted");
		java.util.GregorianCalendar calendar =
		     new  java.util.GregorianCalendar();
		if (field == HOUR)
			return calendar.get(java.util.GregorianCalendar.HOUR);
		else if (field == MINUTE)
		    return calendar.get(java.util.GregorianCalendar.MINUTE);
		else
		    return -1;
	}
}

package fr.nantes.univ.quality;

/**********************
 * Classe Java AlarmClock
 * Avec ce réveil simpliste, l'utilisateur peut choisir la sonnerie et l'heure de sonner. 
 * Le réveil doit être activé tous les jours pour sonner à l'heure prévue.
 * Ainsi quand le réveil sonne, cela le désactive.
 * 
 * @author Arnaud Lanoix, Jean-Marie Mottu
 * @version 8
 ************************/

public class AlarmClock {

	/**
	 * Défini le numero de sonnerie choisie entre 1 et 10
	 */
	public int ring;

	/**
	 * Heure selectionnée pour la sonnerie : 0 - 23
	 */
	public int hour;

	/**
	 * Minutes sélectionnées pour la sonnerie : 0 -- 59
	 */
	public int min;

	/**
	 * Est-ce que le minuteur est actif, cad est-ce qu'il sonnera une fois le
	 * temps hour:min atteint ?
	 */
	public boolean active;

	/**
	 * Est-ce que le réveil est en train de sonner ?
	 */
	public boolean ringing;
	
	/**
	 * Le constructeur initialise le réveil avec les valeurs passées en
	 * paramètres. 
	 * Le réveil n'est pas actif et il ne sonne pas.
	 * 
	 * @param ring
	 *            choix de sonnerie entre 1 et 10
	 * @param hour
	 *            choix d'heure entre 0 et 23
	 * @param min
	 *            choix des minutes entre 0 et 59
	 * @throws AlarmClockException
	 *             un des paramètres est hors-limite
	 */
	public AlarmClock(int ring, int hour, int min) throws AlarmClockException {
		if (hour < 0) {
			throw new AlarmClockException("bad hour: inf value");
		} else if (hour > 23) {
			throw new AlarmClockException("bad hour: sup value");
		} else if (min < 0) {
			throw new AlarmClockException("bad min: inf value");
		} else if (min > 59) {
			throw new AlarmClockException("bad min: sup value");
		} else if ((ring < 1) || (ring > 10)) {
			throw new AlarmClockException("bad ring: out of limits");
		} else {
			this.ring = ring;
			this.hour = hour;
			this.min = min;
		}
		active = false;
		ringing = false;
	}

	/**
	 * Cette méthode permet de choisir une nouvelle sonnerie, uniquement si le
	 * réveil n'est pas en train de sonner.
	 * 
	 * @param ring
	 *            choix de sonnerie entre 1 et 10
	 * @throws AlarmClockException
	 *             le choix de sonnerie est invalide
	 */
	public void selectRing(int ring) throws AlarmClockException {
		if (!ringing) {
			if ((ring < 1) || (ring > 10)) {
				throw new AlarmClockException("bad ring: out of limits");
			}
			this.ring = ring;
		}
	}

	/**
	 * Cette méthode incrémente le temps avec les minutes en paramètre. Elle
	 * change donc l'heure et les minutes enregistrées précédemment.
	 * 
	 * @param addedmin
	 *            min à ajouter au temps enregistré précédemment
	 * @throws AlarmClockException
	 *             addedmin est negatif
	 */
	public void addMin(int addedmin) throws AlarmClockException {
		int addedhour = 0;
		int newmin = 0;
		int newhour = 0;
		if (addedmin < 0) {
			throw new AlarmClockException("bad min: inf value");
		}
		while (addedmin > 59) {
			addedhour++;
			addedmin = addedmin - 60;
		}
		newmin = this.min + addedmin;
		if (newmin > 59) {
			addedhour++;
			newmin = newmin - 60;
		}
		newhour = this.hour + addedhour;
		while (newhour > 23) {
			newhour = newhour - 24;
		}
		this.hour = newhour;
		this.min = newmin;
	}

	/**
	 * Cette méthode active/desactive le reveil alternativement. 
	 * Si le réveil est activé à l'heure de sonner, alors il sonne.
	 */
	private void setActive() {
		if(!ringing){
			this.active = !this.active;
			if (this.active) {
				Calendar cal = new Calendar();
				if (this.hour == cal.get(Calendar.HOUR))
					if (this.min == cal.get(Calendar.MINUTE))
						ringing = true;
			}
		}
		
	}

	/**
	 * Cette methode éteint la sonnerie du réveil.
	 * @param prolonge
	 * 		Si le paramètre prolonge est à vrai alors le réveil est réactivé et paramétré pour sonner dans 5 min.
	 * @throws AlarmClockException 
	 */
	public void eteindre(boolean prolonge) throws AlarmClockException {
		this.ringing = false;
		if (prolonge){
			this.active = true;
			this.addMin(5);
		}	
	}
	
	/**
	 * @param object
	 *            objet à comparer pour l'égalite
	 * @return true si l'objet est égal au réveil courant
	 */
	public boolean equals(Object object) {
		if (object != null && object instanceof AlarmClock) {
			return this.ring == ((AlarmClock) object).ring
					&& this.hour == ((AlarmClock) object).hour
					&& this.min == ((AlarmClock) object).min
					&& this.active == ((AlarmClock) object).active
					&& this.ringing == ((AlarmClock) object).ringing;
		} else
			return false;
	}

	/**
	 * @return une chaine de caractères caractérisant le réveil
	 */
	public String toString() {
		String str = "Set at ";
		str += hour + ":" + min;
		if (active)
			str += "  (active)";
		if (ringing)
			str += " (ringing)";
		return str;
	}

	public static void main(String args[]) {
		try {
			AlarmClock ac = new AlarmClock(3, 12, 30);
			ac.setActive();
			System.out.println(ac);
			ac.addMin(55);
			ac.setActive();
			System.out.println(ac);
		} catch (AlarmClockException e) {
			System.out.println(e);
		}
	}

}

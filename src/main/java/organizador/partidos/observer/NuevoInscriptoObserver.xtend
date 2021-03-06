package organizador.partidos.observer

import organizador.partidos.partido.Partido
import organizador.partidos.jugador.Jugador
import organizador.partidos.correo.Mail
import organizador.partidos.correo.EnviadorDeMails
import java.io.Serializable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.OneToOne
import javax.persistence.Column
import javax.persistence.JoinColumn

@Entity
class NuevoInscriptoObserver implements Serializable {
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id
	
	@OneToOne
	@JoinColumn(name="mailAvisoNuevoJugador")
	@Property Mail mailAvisoNuevoJugador
	
	@OneToOne
	@JoinColumn(name="enviadorDeMails")
	@Property EnviadorDeMails enviadorDeMails

	def notificarALosJugadoresQueSeInscribioAlguien(Partido partido, Jugador jugadorQueSeInscribio) {
		this.crearMailDeAvisoNuevoJugador(jugadorQueSeInscribio)
		this.enviarMailDeAvisoAJugadores(mailAvisoNuevoJugador, partido)
			
		
	}
	

	def enviarMailDeAvisoAJugadores(Mail mail, Partido partido) {
		partido.inscriptos.forEach[inscripto|enviadorDeMails.enviarMail(mail, inscripto.correo)]
	}

	def crearMailDeAvisoNuevoJugador(Jugador jugador) {
		mailAvisoNuevoJugador = new Mail("Se ha unido un nuevo jugador", "Nuevo jugador" + jugador.nombre)

	}

	def aniadirEnviadorDeMails(EnviadorDeMails enviador) {

		this.enviadorDeMails = enviador

	}

}

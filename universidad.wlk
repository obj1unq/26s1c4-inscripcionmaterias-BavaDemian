class Carrera {
    const property materias = #{} // Uso property para ahorrar el getter
}

class Materia {
    const property inscriptos = #{}
    const property correlativas = #{}
    const property listaDeEspera = []
    var cupo = 0
    var creditos = 0 
    var año = 0

    method cantidadDeCreditosQueOtorga() = creditos

    method puedeInscribirse(estudiante) =
      estudiante.materiasTotales().contains(self)
      and !estudiante.aprobo(self)
      and !self.estaInscripto(estudiante)
      and self.tieneAprobadasCorrelativas(estudiante)

    method estaInscripto(estudiante) = inscriptos.contains(estudiante) 

    method inscribir(estudiante) {
      if(!self.puedeInscribirse(estudiante)){
        self.error("No cumple las condiciones")
      
      }
      self.verificarCupoParaInscribir(estudiante)	
    } 

    method verificarCupoParaInscribir(estudiante) {
      if(inscriptos.size() <= cupo){
        listaDeEspera.add(estudiante)
      } else {
        inscriptos.add(estudiante)
      }
    }

    method tieneAprobadasCorrelativas(estudiante) = correlativas.all({ materia => estudiante.aprobo(materia) })

    method darDeBaja(estudiante) {
      inscriptos.remove(estudiante)
      if(!listaDeEspera.isEmpty()){
        const primeroEnEspera = listaDeEspera.first()
        inscriptos.add(primeroEnEspera)
        listaDeEspera.remove(primeroEnEspera)
      }
    }
    
    method puedeHacerTrabajoFinal(estudiante) = estudiante.creditosTotales() > 250

	  method inscriptos() = inscriptos // Los estudiantes inscriptos a una materia dada.
	  method listaDeEspera() = listaDeEspera  // Los estudiantes en lista de espera para una materia dada.
}

class MateriaAprobada {
    const property materia
    const property nota
}

class Estudiante {
    const property carreras = #{}
    const property materiasAprobadas = #{}
    var property creditosTotales = 0

    method materiasTotales() = carreras.flatMap({ carrera => carrera.materias() })

    method aprobo(materiaASaber) = materiasAprobadas.any({ matAprobada => matAprobada.materia() == materiaASaber })

    method cantidadAprobadas() = materiasAprobadas.size() // CANTIDAD DE MATERIAS APROBADAS

    method notas() = materiasAprobadas.map({ materia => materia.nota() }) // NOTAS

    method promedio() = self.notas().average() // PROMEDIO DE NOTAS

    method aprobar(_materia, _nota) {
      if (self.aprobo(_materia)){
        self.error("...")
      }
      const nuevaMateriaAprobada = new MateriaAprobada(materia = _materia, nota = _nota)
      materiasAprobadas.add(nuevaMateriaAprobada)
    }

    method materiasQueEstaInscriptoDeCarreras() = carreras.materias().flatten()

    method materiasQueSePuedeInscribir(carrera) {
      if(!carreras.contains(carrera))
        {self.error("No cursa esta carrera")}
      else
        carrera.materias().filter({ materia => materia.puedeInscribirse(self) }) 
    }

    method materiasInscripto() = self.materiasTotales().filter({ materia => materia.estaInscripto(self) })
}


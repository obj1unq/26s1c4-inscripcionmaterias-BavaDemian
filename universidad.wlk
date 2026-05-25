class Carrera {
    const materias = #{}

    method materias() = materias   
}

class Materia {
    const inscriptos = #{}
    const correlativas = #{}
    const listaDeEspera = []
    var cupo = 0
    var creditos = 0 
    var año = 0

    method cantidadDeCreditosQueOtorga() = creditos

    method puedeInscribirse(estudiante) = estudiante.materiasTotales().contains(self) and !estudiante.aprobo(self) and !self.estaInscripto(estudiante) and self.tieneAprobadasCorrelativas(estudiante)  // 

    method estaInscripto(estudiante) = self.inscriptos().contains(estudiante) 

    method inscribir(estudiante) {
      if(!self.puedeInscribirse(estudiante)){
        self.error("No cumple las condiciones")
      
      }
      self.verificarCupoParaInscribir(estudiante)	
    } 

    method verificarCupoParaInscribir(estudiante) {
      if(inscriptos <= cupo){
        listaDeEspera.add(estudiante)
      }
      inscriptos.add(estudiante)
    }

    method tieneAprobadasCorrelativas(estudiante) = correlativas.all({ materia => estudiante.aprobo(materia) })

    method darDeBaja(estudiante) {
        inscriptos.remove(estudiante)
      if(!listaDeEspera.isEmpty()){
        inscriptos.add(listaDeEspera.first())
      }
    }

    method puedeHacerTrabajoFinal(estudiante) = estudiante.creditosTotales() > 250

	  method inscriptos() = inscriptos // Los estudiantes inscriptos a una materia dada.
	  method listaDeEspera() = listaDeEspera  // Los estudiantes en lista de espera para una materia dada.
}

class MateriaAprobada {
    const materia = null
    const nota = 0

    method materia() = materia
    method nota() = nota

    method esMateriaAprobada(materiaAVer) = materiaAVer.materia() == self.materia()
}

class Estudiante {
    const carreras = #{}
    const materiasAprobadas = #{}
    const creditosTotales = 0
    
    method carreras() = carreras

    method creditosTotales() = creditosTotales

    method materiasAprobadas() = materiasAprobadas

    method materiasTotales() = carreras.map({ carreras -> carreras.materias() }).flatten()

    // method esMateriaAprobada(_materia) = 

    method aprobo(materia) = self.materiasAprobadas().contains(materia) // BOOLEANO

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


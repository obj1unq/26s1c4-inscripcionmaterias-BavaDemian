object universidad {
    // Inscripcion?
}

class Carrera {
    
}

class Materia {
    
}


class MateriaAprobada {
    const materia = null
    const nota = 0

    method materia() = materia
    method nota() = nota

    method esMateriaAprobada(materiaAVer) = materiaAVer.materia() == self.materia()
}

class Estudiante {
    const materiasAprobadas = #{}
    
    method materiasAprobadas() = materiasAprobadas

    method aprobo(materia) = materiasAprobadas.any({ materia => materia.esMateriaAprobada(materia) }) // BOOLEANO 

    method cantidadAprobadas() = materiasAprobadas.size() // CANTIDAD DE MATERIAS

    method notas() = materiasAprobadas.map({ materia => materia.nota() }) // NOTAS

    method promedio() = self.notas().average() // PROMEDIO DE NOTAS

    // HOLA PROBANDO
    method aprobar(_materia, _nota) {
      if (self.aprobo(_materia)){
        self.error("...")
      }
      const nuevaMateriaAprobada = new MateriaAprobada(materia = _materia, nota = _nota)
      materiasAprobadas.add(nuevaMateriaAprobada)
    }
}


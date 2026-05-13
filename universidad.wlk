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

    method suma() = materiasAprobadas.sum({ materia => materia.nota() }) // SUMA DE NOTAS

    method promedio() = self.suma() / self.cantidadAprobadas() // PROMEDIO DE NOTAS

    method aprobar(_materia, _nota) {
      if (self.aprobo(_materia)){
        self.error("...")
      }
      const nuevaMateriaAprobada = new MateriaAprobada(materia = _materia, nota = _nota)
      materiasAprobadas.add(nuevaMateriaAprobada)
    }
}


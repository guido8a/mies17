package mies

class Cobertura implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'cbrt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cbrt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cbrt__id'
            descripcion column: 'cbrtdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción de la cobertura'])
    }

    String toString() {
        "${this.descripcion}"
    }
}
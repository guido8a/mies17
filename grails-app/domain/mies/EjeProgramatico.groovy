package mies

class EjeProgramatico implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'ejpg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ejpg__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'ejpg__id'
            descripcion column: 'ejpgdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, attributes: [mensaje: 'Descripción del eje programático'])
    }

    String toString() {
        return this.descripcion
    }
}
package mies

class GrupoProcesos implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'grpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'grpr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'grpr__id'
            descripcion column: 'grprdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del grupo de procesos'])
    }

    String toString() {
        return this.descripcion
    }
}
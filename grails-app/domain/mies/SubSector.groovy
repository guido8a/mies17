package mies

class SubSector implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'sbst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbst__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sbst__id'
            descripcion column: 'sbstdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del subsector'])
    }

    String toString() {
        return this.descripcion
    }
}
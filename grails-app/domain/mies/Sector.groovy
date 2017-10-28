package mies

class Sector implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'sctr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sctr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sctr__id'
            descripcion column: 'sctrdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, attributes: [mensaje: 'Descripción del sector'])
    }
}
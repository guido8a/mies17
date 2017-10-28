package mies

class TipoInforme implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpif'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpif__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpif__id'
            descripcion column: 'tpifdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de informe'])
    }

    String toString() {
        return this.descripcion
    }
}
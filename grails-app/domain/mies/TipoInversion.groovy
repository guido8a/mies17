package mies

class TipoInversion implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpiv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpiv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpiv__id'
            descripcion column: 'tpivdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del tipo de inversión'])
    }

    String toString() {
        "${this.descripcion}"
    }
}
package mies

class Linea implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'lnea'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'lnea__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'lnea__id'
            descripcion column: 'lneadscr'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, attributes: [mensaje: 'Descripción del lineamiento de inversión'])
    }

    String toString() {
        "${this.descripcion}"
    }
}
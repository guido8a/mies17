package mies

class ObjetivoBuenVivir implements Serializable {
    Integer codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'obbv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obbv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obbv__id'
            codigo column: 'obbvcdgo'
            descripcion column: 'obbvdscr'
        }
    }
    static constraints = {
        codigo(blank: false, nullable: false, attributes: [mensaje: 'Código del objetivo'])
        descripcion(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Descripción del objetivo'])
    }

    String toString() {
        return this.codigo + " - " + this.descripcion
    }
}

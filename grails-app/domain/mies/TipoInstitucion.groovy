package mies

class TipoInstitucion implements Serializable {
    String codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpin'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpin__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpin__id'
            codigo column: 'tpincdgo'
            descripcion column: 'tpindscr'
        }
    }
    static constraints = {
        codigo(size: 1..2, blank: false, nullable: false, attributes:[mensaje:'Código del tipo de institución'])
        descripcion(size: 1..31, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de institución'])
    }

    String toString() {
        return this.descripcion
    }
}